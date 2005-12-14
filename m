From: Don Zickus <dzickus@gmail.com>
Subject: StGIT usage
Date: Wed, 14 Dec 2005 11:44:34 -0500
Message-ID: <68948ca0512140844u677fea36ob94bdf213a6a110@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 17:51:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmZk7-00012T-Oe
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 17:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbVLNQoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 11:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVLNQog
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 11:44:36 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:54823 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932400AbVLNQog convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 11:44:36 -0500
Received: by zproxy.gmail.com with SMTP id 34so145619nzf
        for <git@vger.kernel.org>; Wed, 14 Dec 2005 08:44:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=m0Zc7lByxfyjPBGHn7pe1U97ypDv85uE+cERI71VteUQ0g2Kfu33ntAiTAvG2EwIRCE05vL0jintFnBf368sCicYQ6O3JIah2Tzes/MqqCQmHXYjZz5E35C7RlEr5e2EeFFaopx89Kzn4SBoLPp5WoNIF/fuIzpk2BAuAZWYKUs=
Received: by 10.65.59.11 with SMTP id m11mr544702qbk;
        Wed, 14 Dec 2005 08:44:34 -0800 (PST)
Received: by 10.65.240.20 with HTTP; Wed, 14 Dec 2005 08:44:34 -0800 (PST)
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13632>

I couldn't find in the StGIT documentation on how to use a 'series'
file or to pull a whole bunch of patches from a directory.  It seems
the import command could only handle a patch at a time.  Any
tips/help?

Cheers,
Don
