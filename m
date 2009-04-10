From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [FR] Encrypting the repository
Date: Fri, 10 Apr 2009 13:17:14 +0200
Message-ID: <fabb9a1e0904100417k27d87e76he3b05d078c0a07bd@mail.gmail.com>
References: <loom.20090410T084314-918@post.gmane.org> <fabb9a1e0904100330u61a7e252he546f0edc4e016a7@mail.gmail.com> 
	<49DF294E.7010407@hepe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Aaron Digulla <digulla@hepe.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 13:19:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsElF-0007yy-E1
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 13:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758396AbZDJLRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 07:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758041AbZDJLRb
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 07:17:31 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:44030 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757530AbZDJLRa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 07:17:30 -0400
Received: by fxm2 with SMTP id 2so1003332fxm.37
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 04:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=S1TqcK13fafhZJiwVLw0Dsx+qUE4Qk83mzclX1dO2Hw=;
        b=wBNAv17HrPTjk7XSZ/fdNIUMyzt0BOYn0aeLVjvUpTZlScM4zXaswf29D1ZXVrIP6c
         PMST73Tv2Ir4aKafDLUIhOJw/nb/EODVo0Z6Q/C3UISOYGQpF8Hnd3r92yF+mgMF8a2a
         Fs6jItblrtQsOMMzUMh55eI9tjjvT+9muFzCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=es83CSW5JKOzpUr/+RttXQc1rJ4yCmJ2oGXhoPodJhQolqC2DtRw3yTOHX+a7Qwp4y
         TyAQe39KI7IHFA3vZ7FlL6WVQyLeCCENRtmmte8UMQ7JMu0+vctk+qnhl3v59xsas0Em
         cmOmGN1M2tLHIWBVGQw9mUH0IaEV03JLtlm3o=
Received: by 10.103.228.7 with SMTP id f7mr1794909mur.130.1239362249218; Fri, 
	10 Apr 2009 04:17:29 -0700 (PDT)
In-Reply-To: <49DF294E.7010407@hepe.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116252>

Heya,

On Fri, Apr 10, 2009 at 13:11, Aaron Digulla <digulla@hepe.com> wrote:
> How do I encrypt an Internet drive (like Dropbox)? Also, if possible, I'd
> like not to have to install any software on the local computer (well,
> besides git, obviously).

As long as dropbox allows you to store a file (the file that is
encrypted by TrueCrypt) there is no additional work needed. Obviously
though you will need to install TrueCrypt, under windows there is an
option to create a "traveler disk" (which can be used from the target
(flash) drive without installing additional software IIRC), but I do
not know if it is available for Linux or OSX.

-- 
Cheers,

Sverre Rabbelier
