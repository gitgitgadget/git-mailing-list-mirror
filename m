From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GSoC 2009 Prospective student
Date: Sun, 22 Feb 2009 21:38:51 +0100
Message-ID: <fabb9a1e0902221238g5195edbfg8634f5a9b5638765@mail.gmail.com>
References: <a149495b0902221158h16d499f7w8bd18abaf1321e46@mail.gmail.com>
	 <fabb9a1e0902221207l3a180052hecac2e86210a5bca@mail.gmail.com>
	 <a149495b0902221229p378a1e2ep2c424a15c4458649@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Rohan Dhruva <rohandhruva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 21:40:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbL7f-0007Rz-6m
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 21:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbZBVUiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 15:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbZBVUiz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 15:38:55 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:63611 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbZBVUiy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 15:38:54 -0500
Received: by fxm11 with SMTP id 11so1188878fxm.13
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 12:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1IQJRV2qNFiCZj3Ox7ocdJdM0MNE8S9cq5j/hv7718o=;
        b=LXaiQ7sttGeQpWVxpGYL4GFz1GYPKisjJj7fkllqE4AwU7tO05qxeaK+8Mk5lUfhmF
         PdXrt/2vC5t9I2qRovdJ/mOSliX66kekyhYD67d91JqwrlUzXqauuNXHsbNezITi3Ep6
         9DGiFIqpfVC7kH9o8tyBGX0fL7A2FHz3FhsAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MCTyKG+NIHn3LdJt7+iPoio00bCy09zCxVtrkd1ML3/zvqMgwyPqxHo2IIc7tjRonx
         QGZSUMKJXI+YjCps9AOTVdZSMtFNrADkhfGJXpLeUZxAIjkkZsyvKo7iIzFZb3AadkSG
         7a8wfC5orhlhBOSXGPJ7iFIqpsmYESxh7XaGc=
Received: by 10.103.11.5 with SMTP id o5mr2925007mui.75.1235335131819; Sun, 22 
	Feb 2009 12:38:51 -0800 (PST)
In-Reply-To: <a149495b0902221229p378a1e2ep2c424a15c4458649@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111059>

On Sun, Feb 22, 2009 at 21:29, Rohan Dhruva <rohandhruva@gmail.com> wrote:
> I have developed a particular interest in SCMs lately. Git is a widely
> used SCM. Also, this project would require knowledge of C, and not
> some other language which I am not familiar with.

Ah, that makes sense then. You should make sure you like using git
then, use it in some project for school, perhaps in combination with
'git svn'.

> Seeing that you were a student yourself, can you please give me
> some tips? Any things for me to keep in mind?

Hmmm, work on list! As soon as you have anything half-decent (this
will hopefully be after a week or two three), send your work to the
list for review! Work in the open as much as possible and profit from
the combined knowledge of the mailinglist.
Before GSoC starts, get in contact with possible mentors, try to learn
about the area of the code you will be touching. Learn the coding
style, and learn how to send patches by reading
Documentation/SubmittingPatches and the list archive, but preferably
by sending one!.
Most important is that you have a good time and learn from it though :).

-- 
Cheers,

Sverre Rabbelier
