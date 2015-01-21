From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] contacts: introduce --since and --min-percent
Date: Wed, 21 Jan 2015 12:09:09 -0500
Message-ID: <CALkWK0kE4AOgwN7+U5tqH8PLioMy6yXrcH-XiEpDEDZ4RfT4CQ@mail.gmail.com>
References: <1421441933-54183-1-git-send-email-artagnon@gmail.com> <1421443439-54809-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 18:09:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDymx-0000iR-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 18:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbbAURJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 12:09:52 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:64754 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbbAURJu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 12:09:50 -0500
Received: by mail-ig0-f182.google.com with SMTP id r10so2032523igi.3
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 09:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Su4C1ZbHqeGqo9xw+gaSDEHTdS5yZ8SuuFx9Uai+ZW4=;
        b=SdlU8JZ6BzJs7tsn/Erp0KvY8b2gP1HU8vxywbxIvne+D9UDk2kdUFVy4eGqPA1poH
         ti6uMSWxla1iN1QiT7nOhrXiG7PJWfy+uRTLeOvmM1Jk8PaQIE7m3r8stEOT6U8unmhU
         u1l6QY3KjT6bFRy8dIne+QliwMSBPVl+HQeIa5Tfd/OYVrKGFA4T6OMusTCCKHKLF+m4
         VCYjxaI0vzmIJcxnAuLxmpyJ98CyQegTW39//2dHJvwUdVUU2LdNhQ04qp/3VDn5GAVQ
         5BEohgpuoNlNdNEznPaRXva2b08OlfK8WWAmqyW7J9bZQCaogDiCr5anrugRgoVrYnhb
         IA6Q==
X-Received: by 10.50.112.98 with SMTP id ip2mr18869511igb.15.1421860189902;
 Wed, 21 Jan 2015 09:09:49 -0800 (PST)
Received: by 10.64.102.163 with HTTP; Wed, 21 Jan 2015 09:09:09 -0800 (PST)
In-Reply-To: <1421443439-54809-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262733>

Ramkumar Ramachandra wrote:
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Junio: this isn't in the latest rebuild of pu; I wonder if you've
forgotten to pick it up.
