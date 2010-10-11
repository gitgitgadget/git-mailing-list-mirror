From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/4] Re: Undocumented git-diff syntax
Date: Mon, 11 Oct 2010 22:56:34 +0200
Message-ID: <AANLkTinJBmmZirkM5a9UEOamvJEC_iuPFcNUXZUvv9qO@mail.gmail.com>
References: <20101011150342.292ad725@chalon.bertin.fr> <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr> <20101011160224.GA25842@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <dirson@bertin.fr>,
	=?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 22:57:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5PQb-0004l2-Pe
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 22:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758Ab0JKU44 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 16:56:56 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:64530 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754619Ab0JKU4z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 16:56:55 -0400
Received: by gxk6 with SMTP id 6so261870gxk.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4kyYThiMi+glCLB2qYvmYkWifkB3V0IXodKW+h+90+w=;
        b=lTgH/2bdnxfbzodVqXlM3p0r+oZsqHpKuaaUx7oCKjUvix80+bvOQ5AakZVeAl7lRa
         U9s6E9iM7W227GL2V9C+GsiqaEiWNESLeujAGw2Rjr1uTdaUkyMHhNDdI0kuq4ook8Cz
         X6hhWSGLeqcpUEVPf0/wQfiCDvCu6StgtgEc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=W8VsI6pL6X8RtMSHPf0UohEddBQQTq7VM/1a2UgbmOjvAJlbzNrsmKiXjfBE07c9RM
         Jm2PbPHjWMx4JypKPEV3BySrQVU+G8tW/UaQa6p1hplEXZ88NNnvrfnOHAknZJ/qU0sy
         EEDOupdvAVhOtgQHhd4IowNqKMm2413oBhqBA=
Received: by 10.151.41.21 with SMTP id t21mr2202813ybj.158.1286830614883; Mon,
 11 Oct 2010 13:56:54 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Mon, 11 Oct 2010 13:56:34 -0700 (PDT)
In-Reply-To: <20101011160224.GA25842@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158789>

Heya,

On Mon, Oct 11, 2010 at 18:02, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Patch 5 gives --no-index its own prominent mention in the DESCRIPTION
> section. =C2=A0I suspect that is a bad idea --- too much to learn for=
 new
> users --- and that the description should go under OPTIONS, but I ran
> out of time.

Well, that answers my question in [1/5], *mutters at gmail's lack of a
tree view*.

--=20
Cheers,

Sverre Rabbelier
