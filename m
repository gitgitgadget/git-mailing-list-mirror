From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 15/15] gettextize: git-shortlog basic messages
Date: Mon, 6 Sep 2010 13:41:53 -0500
Message-ID: <20100906184153.GC25426@burratino>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
 <1283775704-29440-16-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 20:43:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osgfd-0004et-Ok
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 20:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab0IFSnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 14:43:53 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50872 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab0IFSnw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 14:43:52 -0400
Received: by qwh6 with SMTP id 6so4039674qwh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 11:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xk62HlGPEUXnAtR8QNCF/3k2qvH4efOEslPmm1LVoxU=;
        b=qzAnBL0oPfiMDJodWiqdlPKm3I1Bvo69b6ZjY175Gx+sY/rlEr7L+BKuEQDcHmA97C
         vdxHmJKb3DWFhxVUVGpzLkvEAk8B4qs/QQK5fW/b4XqWqhcPvw5hj2WpSqw7y3/6pRZ5
         oOrsV8Tj3xFbtBDa4gCh6cj2UG9pOrJASxlH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mHZScyonwi9msKXvyZNeNrqkBuRGNS1Ffw2Q/hrSOIOTXLYGdP+k79EoakJ6AXvinR
         lbNoSUTO/A8Nn+7HYAPl66YjV0Tgx8EvSRg5n1amgBr3XCc+mpjWKrHVKSa8wHx2Rc19
         AfUp0Gic7Z1V+6P/PzHlkf5Q3B/mGg6bh77+g=
Received: by 10.229.96.72 with SMTP id g8mr3820954qcn.190.1283798631423;
        Mon, 06 Sep 2010 11:43:51 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r1sm5917539qcq.34.2010.09.06.11.43.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 11:43:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283775704-29440-16-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155598>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

=46or what it's worth:

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
