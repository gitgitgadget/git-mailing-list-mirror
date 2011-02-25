From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 18/73] gettextize: git-branch "git branch -v" messages
Date: Fri, 25 Feb 2011 01:52:18 -0600
Message-ID: <20110225075218.GE23037@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-19-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 08:52:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PssTY-0000cE-5M
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 08:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab1BYHw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 02:52:27 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46241 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab1BYHw0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 02:52:26 -0500
Received: by vxi39 with SMTP id 39so1166425vxi.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 23:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0izCyqZO6bfHWOodmIX/MHbmHKe9jymu+N2mnoHACZA=;
        b=TRqiP2H8rgI1hGlwQZowa/EsOxoNnpBRowwv7T1X6pES7L4DX55CquPV7eUFPUdU5A
         30nBJ6nCtKC9Bd+xTtG7kXO91KtINLDU+gK+3UwFrtjBNA7lMtsbrU/MtbE0MDM68MpS
         sTxUVH3S6t7MfKsSaz1vNq67RdCNoGh940IkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fE9Sy9CQaYl1IBITiGRrNjPq984Pgx0Z3DRhKdxNzKI9I0sQvTRtBWpqOQKhId0sMy
         gcqUw/cOvC/h2V0mfmwbWk2f2enJ6LyOlTibSVAK/hqyvzq0/JjjUTBVKuT5ahyyr/oP
         19raG9nkPMYdhsiMJgk17Wtm+t68X3AOCdIfM=
Received: by 10.220.189.205 with SMTP id df13mr471840vcb.211.1298620345372;
        Thu, 24 Feb 2011 23:52:25 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id a6sm232843vcm.22.2011.02.24.23.52.23
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 23:52:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298418152-27789-19-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167880>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This is possibly a plumbing message.

Luckily it is not one.

Everything up to here looks good still.
