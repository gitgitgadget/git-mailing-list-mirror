From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Using test-lib.sh under GPLv3?
Date: Fri, 19 Feb 2010 09:44:55 +0100
Message-ID: <fabb9a1e1002190044o5d4feb53td255b1e49a2c969d@mail.gmail.com>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org> <87hbpwpoko.fsf@yoom.home.cworth.org> 
	<5641883d1002060727ia4e6c16lf800a92fc8735430@mail.gmail.com> 
	<201002081614.24284.sojkam1@fel.cvut.cz> <871vgr78lr.fsf@yoom.home.cworth.org> 
	<87iqa2y0gz.fsf@steelpick.localdomain> <87r5oqe7mi.fsf@yoom.home.cworth.org> 
	<871vgmki4f.fsf@steelpick.localdomain> <7vaav8hpfo.fsf@alter.siamese.dyndns.org> 
	<87tytdiqob.fsf@steelpick.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, Carl Worth <cworth@cworth.org>,
	notmuch@notmuchmail.org, git@vger.kernel.org
To: Michal Sojka <sojkam1@fel.cvut.cz>
X-From: git-owner@vger.kernel.org Fri Feb 19 09:45:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiOUG-0007Fj-En
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 09:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab0BSIpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 03:45:17 -0500
Received: from mail-pz0-f192.google.com ([209.85.222.192]:54897 "EHLO
	mail-pz0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0BSIpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 03:45:16 -0500
Received: by pzk30 with SMTP id 30so1089119pzk.22
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 00:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=fI1L6//jmdxoR8iV5S//jKkG2KbflYEZF9J9RfbMmOo=;
        b=YoI92ANYwJg1OL+olITSty4UIFOXkv19V8CVxbaZBAyEHZCJUI/7XfuylMX/hp6MjF
         C9bcV0x2Vd4WXvj4A3s3vo30ftDKx8fx0pwoeNWj8PdXAm6duYWG1uZqGLUjMvxy+jEu
         NnNQI4axnDfcEfSGMevDLAGFNbmVmHmhQiEWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=s2uTppKPDlT1HkeRWkplcUdfuTt4gW1z9q0cgcEcI0t0GdrUN7KMVd+7/NfoTlgRBP
         /x407Ryq5XdEoYRLlfEB23XOaGW26yMKyXOsLCYG1zZ086RDY/Xbzum2+xtNUvrIDW7k
         UoJnw8WnkvUXiygndBBRcJbWx2agZ7j8u3/Hs=
Received: by 10.142.195.19 with SMTP id s19mr7271733wff.312.1266569115168; 
	Fri, 19 Feb 2010 00:45:15 -0800 (PST)
In-Reply-To: <87tytdiqob.fsf@steelpick.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140437>

Heya,

On Fri, Feb 19, 2010 at 09:19, Michal Sojka <sojkam1@fel.cvut.cz> wrote:
> as you can read bellow, I'd like to use git's test-lib.sh in a GPLv3
> project. Do you mind if I use your work in that file under GPLv3?

I don't mind, go right ahead :).

-- 
Cheers,

Sverre Rabbelier
