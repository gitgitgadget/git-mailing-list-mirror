From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsserver problem with eclipse?
Date: Thu, 4 May 2006 00:01:01 +1200
Message-ID: <46a038f90605030501x1d97f60at4d10c8e2c7b4304c@mail.gmail.com>
References: <4455B863.8040808@mobilereasoning.com>
	 <46a038f90605011338i5498f857lf230d9a965aa759@mail.gmail.com>
	 <4456360E.8060305@mobilereasoning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 14:01:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbG2u-000474-68
	for gcvg-git@gmane.org; Wed, 03 May 2006 14:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWECMBG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 08:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWECMBF
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 08:01:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:7051 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965163AbWECMBC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 08:01:02 -0400
Received: by wr-out-0506.google.com with SMTP id 36so113463wra
        for <git@vger.kernel.org>; Wed, 03 May 2006 05:01:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sqjc/bF1ITxo4/ejhYEMsZiqiHFB6DXilsx5qw0A5VQddiZVFPdmTYrcjo8dVHNDAsSgH9buw0hBAGTB7E8LdscQ80cNXIhIt7FyjoDOVbF91NSuO6toxovbq3QeReFqkVGENAdcyTBt06ZSowUrwHnCb7EKzODMvFKCoFRzzcw=
Received: by 10.54.100.11 with SMTP id x11mr1161797wrb;
        Wed, 03 May 2006 05:01:01 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Wed, 3 May 2006 05:01:01 -0700 (PDT)
To: "Bill Burdick" <bill@mobilereasoning.com>
In-Reply-To: <4456360E.8060305@mobilereasoning.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19476>

Bill,

haven't been able to repro your problem at this end. Can you check
your git version? Apparently cvsserver was broken soon after 1.3.0.
Can you try with v1.3.0?

cheers,


martin
