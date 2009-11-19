From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCHv4] Re: gitk french translation
Date: Fri, 20 Nov 2009 00:57:40 +0100
Message-ID: <20091119235740.GA12954@vidovic>
References: <9f50533b0911060605p6ad28ad9neac3620a1809c3db@mail.gmail.com> <9f50533b0911100945l2c3b7399w1d72771fd2cf8df@mail.gmail.com> <20091111001050.GC27518@vidovic> <20091119204753.85765c5d.etrillaud@gmail.com> <20091119210124.8f4a5373.etrillaud@gmail.com> <20091119222331.6ea1e691.etrillaud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Maximilien Noal <noal.maximilien@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Thomas Moulard <thomas.moulard@gmail.com>,
	Guy Brand <gb@unistra.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 00:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBGss-0007we-32
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 00:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917AbZKSX5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 18:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757912AbZKSX5m
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 18:57:42 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:54363 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757737AbZKSX5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 18:57:41 -0500
Received: by ey-out-2122.google.com with SMTP id 4so162837eyf.19
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 15:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=K1Kp8ZEbn3yWiFOYXlKfm1bfHPm5mOT8EKhok9tSof8=;
        b=ouYyAy/+nMyGdAxGbHxPfiraUKYtEeu72gk699iB7lPtzlZbKRrqPKT8HJq4paLbGU
         DBfurUYnHHdFW8hdijD+FKavVEjs/Y1O5CRHJsV/EQh4DJSKxzEoQd/PpUAMSAlwO/k1
         qJvIFzDpbq6x8ncPOjHF1YXJA92OKTNtQETyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AFPOaxBsjH4BMiqUVAjZiy86ixuiv1eP3vWHo3sCo3+RvqYxJVKfYy6dsPKjhOLYnv
         DKTij4EZP+YWaTJudiDFloejsdTgoX5F4xhTeRhoth4Zvu67+AeKx7UTXgA6UdKipZYN
         48vkVWeoAl+DuFHfo70R1493smwSbX/c/BXnU=
Received: by 10.213.23.199 with SMTP id s7mr613732ebb.80.1258675067143;
        Thu, 19 Nov 2009 15:57:47 -0800 (PST)
Received: from @ (91-165-133-111.rev.libertysurf.net [91.165.133.111])
        by mx.google.com with ESMTPS id 7sm260828eyb.10.2009.11.19.15.57.42
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 15:57:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091119222331.6ea1e691.etrillaud@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133269>

The 19/11/09, Emmanuel Trillaud wrote:

> Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
> Signed-off-by: Thomas Moulard <thomas.moulard@gmail.com>
> Signed-off-by: Guy Brand <gb@unistra.fr>
> 
> --

The two dashes are taken as the signature delimiter by my MUA, so I can't
comment without doing an annoying repairing. Please, keep the three
dashes undamaged.

> @@ -0,0 +1,1243 @@
> +
> +# French translation of the gitk package
> +# Copyright (C) 2005-2008 Paul Mackerras.  All rights reserved.
> +# This file is distributed under the same license as the gitk package.
> +# Translators:
> +# Emmanuel Trillaud <etrillaud@gmail.com>
> +#
> +msgid ""
> +msgstr ""
> +"Project-Id-Version: gitk\n"
> +"Report-Msgid-Bugs-To: \n"
> +"POT-Creation-Date: 2009-10-05 15:16+0200\n"
> +"PO-Revision-Date: 2009-11-19 22:11+0100\n"
> +"Last-Translator: YOUR NAME <E-MAIL@ADDRESS>\n"
> +"Language-Team: FRENCH\n"

Could you please fill in these fields?

> +#: gitk:113
> +msgid "Couldn't get list of unmerged files:"
> +msgstr "Impossible de r=E9cup=E9rer la liste des fichiers non fusionn=E9s =
> :"

The whole patch is broken because of wrapped lines like this one. I
can't believe any patch will be merged because the maintainer would have
to manually repair all these lines. Please, disable the line wrapping
option of Sylpheed to inline patches. 

> +#: gitk:2141
> +msgid "Diff"
> +msgstr "Diff=E9rences"

Didn't we agreed on the "Diff" translation?

> +#: gitk:2361 gitk:2378
> +msgid "Diff this -> selected"
> +msgstr "Diff=E9rences entre ceci et la s=E9lection"

Ditto.

> +#: gitk:2362 gitk:2379
> +msgid "Diff selected -> this"
> +msgstr "Diff=E9rence entre s=E9lection et ceci"

Ditto.

> +msgid "<Delete>, b\tScroll diff view up one page"
> +msgstr "<Supprimer>, b\tMonter d'une page dans la vue des diff=E9rences"
> +
> +#: gitk:2706
> +msgid "<Backspace>\tScroll diff view up one page"
> +msgstr "<Backspace>\tMonter d'une page dans la vue des diff=E9rences"
> +
> +#: gitk:2707
> +msgid "<Space>\t\tScroll diff view down one page"
> +msgstr "<Espace>\t\tDescendre d'une page dans la vue des diff=E9rences"
> +
> +#: gitk:2708
> +msgid "u\t\tScroll diff view up 18 lines"
> +msgstr "u\t\tMonter de 18 lignes dans la vue des diff=E9rences"
> +
> +#: gitk:2709
> +msgid "d\t\tScroll diff view down 18 lines"
> +msgstr "d\t\tDescendre de 18 lignes dans la vue des diff=E9rences"

Ditto for all the above.

> +#: gitk:2715
> +msgid "f\t\tScroll diff view to next file"
> +msgstr "f\t\tAller au prochain fichier dans la vue des diff=E9rences"

Ditto.

> +#: gitk:2716
> +#, tcl-format
> +msgid "<%s-S>\t\tSearch for next hit in diff view"
> +msgstr "<%s-S>\t\tAller au r=E9sultat suivant dans la vue des
> diff=E9rences" +
> +#: gitk:2717
> +#, tcl-format
> +msgid "<%s-R>\t\tSearch for previous hit in diff view"
> +msgstr "<%s-R>\t\tAller au r=E9sultat pr=E9c=E9dent dans la vue des
> diff=E9rences" +

Ditto.

Ok, I stop here the review. It really looks like you've sent a wrong
patch; maybe an earlier version which doesn't include the previous
comments.

-- 
Nicolas Sebrecht
