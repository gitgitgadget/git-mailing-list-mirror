From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 04/18] revert: Don't check lone argument in get_encoding
Date: Thu, 28 Jul 2011 21:13:21 +0530
Message-ID: <CALkWK0nmR1weev=agRiwWyBn=KSRQBg=FxDE0x0mrMNAs9Nq5g@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-5-git-send-email-artagnon@gmail.com> <20110727043205.GC18470@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 17:43:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmSkW-0003V0-GR
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 17:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab1G1Pnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 11:43:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56488 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab1G1Pnm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 11:43:42 -0400
Received: by wyg8 with SMTP id 8so225558wyg.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DZBDScMlHtSKCZaSTJ3uKnx2twxlx5qcFzahna7p9zo=;
        b=uBH7kxTM73cAOMTjivAkaj4pM4aMfcOVS4HfDSZ1R3qegzw/rcX+72uSnA4v+MqMNZ
         nDHQcHBoxRF3kqOskXbFZma8mRmtuRSUjdeYWYwGlX8w3o0IglEYBT1BxV1Hn8G6gpM8
         8vZqpT3SHBP/+yC/nufYmFD0hP8xnq0X4nYxE=
Received: by 10.227.153.8 with SMTP id i8mr181577wbw.64.1311867821070; Thu, 28
 Jul 2011 08:43:41 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 08:43:21 -0700 (PDT)
In-Reply-To: <20110727043205.GC18470@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178072>

Hi,

Jonathan Nieder writes:
> The above just doesn't parse for me. =C2=A0Isn't the truth something =
like:
[...]

=46ixed.  Thanks.

-- Ram
