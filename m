From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 11:27:58 -0500
Message-ID: <CACPiFCKNxCHRvom8Qy2PErE92tCmYJhqB+FSawCsFSsdGUFH6Q@mail.gmail.com>
References: <jbvj5o$skt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 11 17:28:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZmGN-0006SB-2w
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 17:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116Ab1LKQ2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Dec 2011 11:28:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41821 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab1LKQ2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2011 11:28:19 -0500
Received: by iaeh11 with SMTP id h11so1823379iae.19
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 08:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DUT9zqpxFbRkdJ9qbhXHzbzii1NZG84goyi3wW8Iy/o=;
        b=SkYquBFSVroVJVZF0gF/6qGLxHb65uFrRyumUFaMTq2s0bMVNYD3daCjy379quOweF
         m1mfMmk8ZRoSg7Jx+UCRUEWs8guUoGPFtiJ4dgTX3u7tErt1FAz63bTC/ij0Juztp6yN
         YWziuCDmx+Qo2W0AaZmPqAvPPcm+ob4fhIFpw=
Received: by 10.42.151.65 with SMTP id d1mr9815049icw.18.1323620899290; Sun,
 11 Dec 2011 08:28:19 -0800 (PST)
Received: by 10.42.189.133 with HTTP; Sun, 11 Dec 2011 08:27:58 -0800 (PST)
In-Reply-To: <jbvj5o$skt$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186804>

On Sat, Dec 10, 2011 at 7:26 AM, Gelonida N <gelonida@gmail.com> wrote:
> What is the best way to fastforward all fastforwardable tracking
> branches after a git fetch?

It'd be a great addition to git fetch ;-)


m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- Software Architect - OLPC
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
