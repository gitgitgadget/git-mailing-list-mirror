From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] Documentation/remote-helpers: Rewrite description
Date: Mon, 19 Apr 2010 00:09:17 +0530
Message-ID: <y2qf3271551004181139le9bc067l9caaeaa9b86a737b@mail.gmail.com>
References: <1271551934-sup-1118@kytes> <20100418022900.GA1669@progeny.tock> 
	<7vochgwr1v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:39:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZPD-0004Eb-8G
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407Ab0DRSji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Apr 2010 14:39:38 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:52522 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab0DRSjh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Apr 2010 14:39:37 -0400
Received: by yxe29 with SMTP id 29so2107543yxe.4
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=aMn015tPly1kDfo5LUyKdv8ZSw143/IS5HpBLzOo2RE=;
        b=nqafhZX+HGGqRsnITf3WeSuoz/God/RzXunS6qiBZaLptggUa4qK8YGlubeGVRQsN7
         E6bKNs0OeSbVwXhTdWJQQXEJdRS8Clq6T7blZKOlxaWvga0wIbEZo/ewlaM0z1bLlEaC
         w8UwWGQzcZzg0kYEPKRo/UYsnNIAbsdFbKbAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VlbVex1tmOTDQOS6sXA8tJJ5fltxypvKvHI73dNelKQL8/OdojPL/8ZpOG9dxxw+yV
         Ye9RAeSv69NZ//CxyEqFEmKwF63q8A7FzDJtY+LNwgKjcs04MJUIkaMtMmk+8vT/4vzh
         Ghqk3Yk6tqM8bI4iKrBLfPC4zoJR4t0WPYzDE=
Received: by 10.90.69.14 with HTTP; Sun, 18 Apr 2010 11:39:17 -0700 (PDT)
In-Reply-To: <7vochgwr1v.fsf@alter.siamese.dyndns.org>
Received: by 10.91.97.7 with SMTP id z7mr2472471agl.89.1271615977139; Sun, 18 
	Apr 2010 11:39:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145232>

Hi,

> I think this is much easier to read. =C2=A0If it is Ok with
> Ramkumar, I'd squash this into the first one in the series.

Okay, sounds good.

-- Ram
