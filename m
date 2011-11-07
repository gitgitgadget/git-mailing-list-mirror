From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] pull: introduce a pull.rebase option to enable --rebase
Date: Mon, 7 Nov 2011 13:44:14 +0100
Message-ID: <CACBZZX5Lq7vunx-QnsrufQVWJ6xYPoMXnv+tMwhOC3XbrZO11A@mail.gmail.com>
References: <7v8vnt7kvd.fsf@alter.siamese.dyndns.org> <1320573010-12296-1-git-send-email-avarab@gmail.com>
 <4EB6E5AD.7060605@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 13:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNOZ7-0001Gv-Cz
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 13:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404Ab1KGMoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 07:44:37 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51529 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835Ab1KGMog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 07:44:36 -0500
Received: by bke11 with SMTP id 11so3538553bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 04:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e2Num46uHnQz+NTZwm2lObV+j+oxaU941Q/50ALn0aY=;
        b=KpKGau/OgF4geotR+cMxlh11cJep2taZ/kGAnxGQT+/W0zMC1QmZLtWjXa2GLw+dka
         WSnN9yfXN7q4XxDTpsUdNpj/fiRzsuis8IeIvXVejmCyjhjxyNJsPIdbTezbkphnxnqp
         JvFx1M3PKtjE/dM76rNv8WgLBYFb7eFo0LtF4=
Received: by 10.205.122.144 with SMTP id gg16mr2899928bkc.97.1320669875137;
 Mon, 07 Nov 2011 04:44:35 -0800 (PST)
Received: by 10.204.118.67 with HTTP; Mon, 7 Nov 2011 04:44:14 -0800 (PST)
In-Reply-To: <4EB6E5AD.7060605@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184981>

On Sun, Nov 6, 2011 at 20:53, Johannes Sixt <j6t@kdbg.org> wrote:
> When you continue an indented item in a separate paragraph, then you
> must not use an empty line, but have line with '+' and un-indented
> continuation paragraphs. See examples in this file.

Thanks for spotting that.

Junio: Should I spam you with another patch or is something you'd
prefer to just fix up?
