From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: remote to push to local branch: hung up unexpectedly
Date: Wed, 13 Jan 2010 22:15:38 +0800
Message-ID: <be6fef0d1001130615k17855680s57952498260ad09d@mail.gmail.com>
References: <20100113130843.GA13545@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 15:15:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV40d-0005Y0-Eo
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 15:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210Ab0AMOPj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 09:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755192Ab0AMOPj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 09:15:39 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:47032 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab0AMOPi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 09:15:38 -0500
Received: by iwn35 with SMTP id 35so16386319iwn.4
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 06:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=S34Wk3sUEzyPosXfhHKvYXOsk50Fih+SPq171MhGVgc=;
        b=i5pCSaQjmIDgK7srjiUwUZIgxfpB6sJ6ioFJHPYLba3zA/iOOAHNGcTUeE4rUaLoWk
         MwRyQSxYLBwIoimqICXrGn+Kb7jv2f63l83bv2Rgs41nA3vN7I8kEzoLbiMJaemh2Hvx
         +6Ad2QMZ9bLa2ZXWgBgBE4Taoc4z5Mi5eZyQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ME9Puj6Uuubk5CS4/9Dh+QHpeO0efoae7TQ/DWY01S383hU/WDf5lOIFZ/sGbgMKdQ
         suc5yZwIUkt+frB2X9USADk3365RDPQqBuM1oPliQ+1POunD95BmCzvhgsD3slEfehcY
         WgUlTxDg8rv6od6OHWj7OK1LIxJJB9hmMeG3M=
Received: by 10.231.120.90 with SMTP id c26mr2160456ibr.1.1263392138040; Wed, 
	13 Jan 2010 06:15:38 -0800 (PST)
In-Reply-To: <20100113130843.GA13545@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136823>

Hi,

On Wed, Jan 13, 2010 at 9:08 PM, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> with url =3D /scm/qemu =A0 (this is repo path)

Are you working in a "normal" git setup with a .git folder and the
files checked out? Or are you working with a --bare repo?

--=20
Cheers,
Ray Chuan
