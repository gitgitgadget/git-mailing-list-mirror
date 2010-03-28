From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v6] Improve remote-helpers documentation
Date: Sun, 28 Mar 2010 23:35:39 +0530
Message-ID: <f3271551003281105m4b88c52epb7b09f8814099023@mail.gmail.com>
References: <f3271551003230045v523d2088v18b21a4a5c424ff0@mail.gmail.com> 
	<f3271551003230238y6143d770h4e23686d41fce667@mail.gmail.com> 
	<f3271551003280932l6fde201fpf2096dd368c13c84@mail.gmail.com> 
	<7v8w9c2vfk.fsf@alter.siamese.dyndns.org> <7v4ok01giu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 20:06:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvwsC-0003FK-To
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 20:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab0C1SGB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Mar 2010 14:06:01 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:42404 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab0C1SGA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Mar 2010 14:06:00 -0400
Received: by ywh36 with SMTP id 36so2912244ywh.4
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 11:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=IHAxIUKrnzKLDbsLqLjMv0kYyoR+docHr57tKIMT0VY=;
        b=P0C7UwqaTyDZD0sc9BSeLEF5EP5rl5Fc920IqXn2XMRvfLr1eshdrmtb5LAejV12e2
         XopqGKrLDxs5u7YZD3IRbcea6kuZw7cFfKGt3rI2uOYNzlrtBISLYHNkU49myWKLWXFu
         2itDUZ2/FrCEBg53tfK/nUOrWI4AJKVVG92io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=d8ZaPCLHCEALgHtMPUQEWiDQ64psCZX2KPyaeDrlvuxLBlugw6HfNVGIlFUfMIKZwl
         Cvd9A5hDa5l09/vL1RdXZlDiCbuX9PV5PWRAia+U0QOTkTgZ/Jvqg0HEOVpZNFyDxeRT
         aghb0kVIXTiZitoEQq63n+grNXacdbMqi7iA0=
Received: by 10.90.69.14 with HTTP; Sun, 28 Mar 2010 11:05:39 -0700 (PDT)
In-Reply-To: <7v4ok01giu.fsf@alter.siamese.dyndns.org>
Received: by 10.90.62.2 with SMTP id k2mr2542279aga.79.1269799559791; Sun, 28 
	Mar 2010 11:05:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143413>

> ... except that the message is corrupt and does not apply. =A0Here is=
 an
> excerpt from it, before decoding MIME and quoted-printable.

Ouch. I've just prepared a v7- I hope that applies cleanly. It's in
two parts now.

-- Ram
