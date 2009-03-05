From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: notes, was Re: What's cooking in git.git (Mar 2009, #02; Thu, 05)
Date: Thu, 5 Mar 2009 13:40:03 +0100
Message-ID: <2c6b72b30903050440k6f9533bbq605d5f06161dff92@mail.gmail.com>
References: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0903051204010.6524@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 05 13:41:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfCtM-0000Cs-9o
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 13:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbZCEMkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 07:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbZCEMkH
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 07:40:07 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:59971 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbZCEMkG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 07:40:06 -0500
Received: by fxm24 with SMTP id 24so3328210fxm.37
        for <git@vger.kernel.org>; Thu, 05 Mar 2009 04:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f/lUfGcSILa+19N8gFEOLzFSmsU1pvy89l+VJn6ejLI=;
        b=GUPD24S8T+fuFV4tJzUnt6bigm0w67e9SR7PiyZ3rxwaDx5QBf+oIgS9BG6YCrVCiS
         NZlBBfYqo/5a06BwaqH2r35iG3hyEo8JOTLH0+wtz11S+my7moWn3abz+lRpwYQVLWtL
         ATfYSgJvHOGkkK/sAQTUS+KYo8R7vsvJ3msdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F0Qtn7Yy+X8QQoMODJzCSJHIoHOkKLhU5JPdg8LcEg8q4NxJtKBfVLLtBl+YWitrwP
         3Yq8S7+Azj/yT/6UhKCjpKRbNPJmCgM7i6+8iXO6/5P1yYNm7qCg0yJZGCmT0nNhfvOt
         gax6zGpEBMLEwF9KXYMwUuwT8Trqe1ZNaYVbc=
Received: by 10.181.151.18 with SMTP id d18mr355411bko.183.1236256803704; Thu, 
	05 Mar 2009 04:40:03 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0903051204010.6524@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112305>

On Thu, Mar 5, 2009 at 12:04, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 5 Mar 2009, Junio C Hamano wrote:
>
>> * js/notes (Wed Feb 18 11:17:27 2009 -0800) 14 commits
>>
>> Rebased and then kicked back to 'pu' to give the author a chance to
>> rearrange if necessary. =A0I might do some trivial squashing myself.
>
> Will do.

Although laziness should not be rewarded, this might be something that
you could squash in as well.

--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -43,4 +43,4 @@ Documentation by Johannes Schindelin

 GIT
 ---
-Part of the gitlink:git[7] suite
+Part of the linkgit:git[7] suite

--=20
Jonas Fonseca
