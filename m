X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Chris Riddoch" <riddochc@gmail.com>
Subject: The patch documenting --pretty options (oops)
Date: Fri, 17 Nov 2006 23:28:47 -0700
Message-ID: <6efbd9b70611172228p69ecb3e6mfd1c60d349968cce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 06:28:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=o1zZPe1Yh4/rIVZfHPN37f3Re+a6fizyzsi7LAXO8ml6jsLaQaG5fglwJ35zl7aJtjJvi3AzOp5QadFZFB7/T0tyV/jCyrItkIII6zG21kdcV1oRBw0zJNbANRYezYLDv3OVFcQbaQCP5syIaLD4C5cCBI93bEI00CzK2hP0hbU=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31760>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlJh7-00053j-5j for gcvg-git@gmane.org; Sat, 18 Nov
 2006 07:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756051AbWKRG2t (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 01:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756056AbWKRG2t
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 01:28:49 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:64776 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1756051AbWKRG2s
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 01:28:48 -0500
Received: by wx-out-0506.google.com with SMTP id s7so1195263wxc for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 22:28:48 -0800 (PST)
Received: by 10.70.61.1 with SMTP id j1mr2794wxa.1163831327697; Fri, 17 Nov
 2006 22:28:47 -0800 (PST)
Received: by 10.70.59.14 with HTTP; Fri, 17 Nov 2006 22:28:47 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi, folks.

I'm terribly sorry about the repost of my old patch.  I fixed it,
adding more information about the rest of the output formats and the
'Merge: ' line, but then accidentally reposted the original one.  I
hope this new version addresses your original concerns with my patch,
Junio.

-- 
epistemological humility
