From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #05; Wed, 28)
Date: Wed, 28 Oct 2009 15:09:22 -0700
Message-ID: <fabb9a1e0910281509r1c88615y7dc85e529ac032f3@mail.gmail.com>
References: <7vfx93jkb1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 23:09:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3GiC-0008WR-Ho
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 23:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbZJ1WJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 18:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbZJ1WJj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 18:09:39 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:62262 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbZJ1WJi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 18:09:38 -0400
Received: by ewy4 with SMTP id 4so1246704ewy.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 15:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=plqT09IqUY+k2yNsSuGMRBvzTWojk5wD0baBLk9uIDU=;
        b=ZsnJbd2J6iuB40jiRxcck2arjmD3JcS3dPSA3LCdNL4Qg8LHxDLFkl9cd2yxt93Dzn
         P0rZ5yEtOYsqNuytfWVZlpRBmUwOQXkfP6dP/7MBTuBRB/QYvJViBzDS44uh+ixiAuGD
         NRaLGvcPebuE7X9a0uLeyoEg3qbX3QRVaY59c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wkBMnhcyCOPJ5iR42R4V/iG9cq3lDb4ZzrzPR0nItlx8MXPQlfY8egPnHFKCfqfF8i
         4qh9EgEe0dwOFz7uOZkTvi/eT/OYFA5R213w9C6AKb7IsXcZpv5VUbMBcBhNYqXvGNlL
         zdRfFTGH31I+hd0HFJClWzb+mU1Q4BwNoNBcY=
Received: by 10.216.87.133 with SMTP id y5mr1188958wee.139.1256767782093; Wed, 
	28 Oct 2009 15:09:42 -0700 (PDT)
In-Reply-To: <7vfx93jkb1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131501>

Heya,

On Wed, Oct 28, 2009 at 14:11, Junio C Hamano <gitster@pobox.com> wrote=
:
> * sr/gfi-options (2009-09-06) 6 commits.
> =A0- fast-import: test the new option command
> =A0- fast-import: add option command
> =A0- fast-import: test the new feature command
> =A0- fast-import: add feature command
> =A0- fast-import: put marks reading in it's own function
> =A0- fast-import: put option parsing code in separate functions
>
> ???

Repinged Shawn and the vcs list to decide what to do, I really want to
get this done with...

--=20
Cheers,

Sverre Rabbelier
