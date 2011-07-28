From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 00/18] GSoC update: Sequencer for inclusion v3
Date: Thu, 28 Jul 2011 22:02:01 +0530
Message-ID: <CALkWK0=d_JEy=24Sqg7Np12wsV754kbw_ejpFJsKttDc4t2g1Q@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <7vfwlrmisu.fsf@alter.siamese.dyndns.org> <CALkWK0kWtdHD2JF+sP8ox96jPncZagQpHzu3vvggyEFO3D2ryw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:32:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTVc-0007Vf-BB
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546Ab1G1QcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 12:32:24 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59636 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755467Ab1G1QcW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 12:32:22 -0400
Received: by wwg11 with SMTP id 11so4181655wwg.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZuHWh3GBxvktrZ4L/fP8IOm2K/ihU0Pe8e719Ti/HoE=;
        b=Iy0qczCk1JxYKGyKg2zjqsbYy/jd4ZKq7TlVDUy/fHpolaPbLF0bmJVtDl1NsJ4Cu6
         Kslw5EZdy47FUC7OX41y+X/snsyGfV4KzIPfPOEfesaL0uzymbT+72hQfutwdErIsXTD
         z9u8gNnR55K9eDCtue882BFLf9FQ6GpO9IiRQ=
Received: by 10.227.57.209 with SMTP id d17mr221994wbh.94.1311870741160; Thu,
 28 Jul 2011 09:32:21 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 09:32:01 -0700 (PDT)
In-Reply-To: <CALkWK0kWtdHD2JF+sP8ox96jPncZagQpHzu3vvggyEFO3D2ryw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178077>

Hi again,

Ramkumar Ramachandra writes:
> Do you think the series is alright otherwise? =C2=A0I'll post another
> iteration of the sequencer momentarily.

Um, one more thing.  I've also decided to let Jonathan's commit
signoff-factoring patch [1] wait until the next series.

[1]: https://github.com/artagnon/git/commit/0494a

Thanks.

-- Ram
