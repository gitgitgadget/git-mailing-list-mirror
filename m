From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: CR codes from git commands
Date: Sun, 25 Jan 2009 10:47:13 -0800
Message-ID: <18812.46001.81309.374547@hungover.brentg.com>
References: <18805.64312.289059.660023@hungover.brentg.com>
	<alpine.DEB.1.00.0901231747340.21467@intel-tinevez-2-302>
	<18811.32772.728276.923430@hungover.brentg.com>
	<200901250319.05665.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Brent Goodrick <bgoodr@gmail.com>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Jan 25 19:48:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRA2D-0003JR-HX
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 19:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbZAYSrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbZAYSrR
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:47:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:58604 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbZAYSrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:47:16 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5530769rvb.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 10:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:mime-version
         :content-type:content-transfer-encoding:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer;
        bh=3/VBHmejJo07MpwoBDmfzHQXAcI00W+GG/dDWUYdJo8=;
        b=bs/HCvOYkBE0SDKS101u0jljoclWqpibtx1JxLyN71Us+FYzuxJFux/oBMpb1x9x2k
         hspjvLTp7AgbX4HmVyiBDtZs7VhaLDZMFVOjRwHfb+qssVvE7Fc6Hd9w3kGVOPM+ES++
         t5woKTno4LuIzpCPrmjYRRfB7D/WHRMmyIFv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:mime-version:content-type:content-transfer-encoding:message-id
         :date:to:cc:subject:in-reply-to:references:x-mailer;
        b=jWsmErlFTXeYk+TXPckp9AZG8iazyfqK38Com6IKY2RaKRok9KWoVM0nvT6OhXZEY/
         q6UTqgGpMFK8gpWa8R5z+BbCzHSbqM+PoPRKUNvs4flvYPxzoacUW19qaU/bcKFsIFv2
         TfEKcMBpDIZSmQ/FTF/W2S50S/FWUGj1qIY5w=
Received: by 10.140.139.3 with SMTP id m3mr1332360rvd.270.1232909236084;
        Sun, 25 Jan 2009 10:47:16 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id f21sm28550846rvb.7.2009.01.25.10.47.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jan 2009 10:47:15 -0800 (PST)
In-Reply-To: <200901250319.05665.bss@iguanasuicide.net>
X-Mailer: VM viewmail-609 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107078>


Boyd Stephen Smith Jr. writes:
 > On Saturday 24 January 2009, Brent Goodrick <bgoodr@gmail.com> wrote 
 > about 'Re: CR codes from git commands':
 > >While I'm at it, what is the standard procedure for submitting git
 > >patches for review once I've cooked up and validated it on my end? I'm
 > >guessing posting the patch into this mailing list is part of the
 > >answer to that question.
 > 
 > If you've got a patch, I assume you've got a checkout.  Look in 
 > Documentation/SubmittingPatches.

Thanks I see that now. No, I don't have a patch yet, was struggling to
find that basic info that really should be front and center somewhere
on the wiki (and also access to the wiki is very slow).

bg
