From: Tay Ray Chuan <rctay89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] test-lib.sh: Add explicit license detail,
	with change 	from GPLv2 to GPLv2+.
Date: Tue, 23 Feb 2010 11:51:58 +0800
Message-ID: <be6fef0d1002221951j77bd5fcjfdee33aa41e5fdbe@mail.gmail.com>
References: <87ljf8pvxx.fsf@yoom.home.cworth.org>
	<7vaav8hpfo.fsf@alter.siamese.dyndns.org>
	<87tytdiqob.fsf@steelpick.localdomain>
	<alpine.DEB.1.00.1002191138280.20986@pacific.mpi-cbg.de>
	<873a0xhwxs.fsf@yoom.home.cworth.org>
	<alpine.DEB.1.00.1002192204050.20986@pacific.mpi-cbg.de>
	<87eikfhec1.fsf@yoom.home.cworth.org>
	<7vaav3bnr5.fsf@alter.siamese.dyndns.org>
	<87y6ilf4w7.fsf@yoom.home.cworth.org>
	<7vljekipnd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Johannes Sixt <j6t-FFprn4rPSa4@public.gmane.org>,
	Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>,
	Pierre Habouzit <madcoder-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org, Sverre Rabbelier <srabbelier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
X-From: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org Tue Feb 23 04:52:05 2010
Return-path: <notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>
Envelope-to: gmn-notmuch@m.gmane.org
Received: from u15218177.onlinehome-server.com ([82.165.184.25] helo=olra.theworths.org)
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>)
	id 1NjloZ-0004T3-Px
	for gmn-notmuch@m.gmane.org; Tue, 23 Feb 2010 04:52:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 410B5431FC4;
	Mon, 22 Feb 2010 19:52:03 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rfnuyU0IEQAa; Mon, 22 Feb 2010 19:52:02 -0800 (PST)
Received: from olra.theworths.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id CDD7E431FBF;
	Mon, 22 Feb 2010 19:52:01 -0800 (PST)
X-Original-To: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Delivered-To: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id E76A1431FBC
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Mon, 22 Feb 2010 19:52:00 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sNh5OHpsnLqk for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>;
	Mon, 22 Feb 2010 19:52:00 -0800 (PST)
Received: from mail-iw0-f192.google.com (mail-iw0-f192.google.com
	[209.85.223.192])
	by olra.theworths.org (Postfix) with ESMTP id 490AB431FAE
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Mon, 22 Feb 2010 19:52:00 -0800 (PST)
Received: by iwn30 with SMTP id 30so1723538iwn.32
	for <notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>; Mon, 22 Feb 2010 19:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:in-reply-to:references
	:date:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding;
	bh=GczG6oN1CW9YKWC3hkfa5aErYQHDC3g/gKOC56a8UyM=;
	b=UTKnNuDlwKeGNi7Q6GkedkKQ/Mvutjl0htfSHkGW+iPfa9Fw4JhVIY0qJthJxCPsbD
	xOVaFQ3n0Qjnikwkh2vCl1S+lNZhGaafdbbbr+4/YsuGzijdJk1x9FEspeB2eSWiPwp6
	SeKFadXcXL9uy5s9yhrpWRhZ0FghbMihn2uVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	b=MuKJVx+pRUwuQC2XxRRQ/9R5TNWH1qJGIGEjMXNMW/5kj8mUNduq/JtE+q2E3sUdOW
	HjG5cFKNWjlpWzOjPSUH9z2oVhlOqt8yxjzdIEPCrXmCL7pVPGaID7YtimjAbFW4D4Qs
	D8qs+fg3iOxfmgqNvs4tV+MLnD2xZlkZKgm7Y=
Received: by 10.231.160.149 with SMTP id n21mr1788784ibx.93.1266897119008; 
	Mon, 22 Feb 2010 19:51:59 -0800 (PST)
In-Reply-To: <7vljekipnd.fsf-s2KvWo2KEQL18tm6hw+yZpy9Z0UEorGK@public.gmane.org>
X-BeenThere: notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: "Use and development of the notmuch mail system."
	<notmuch.notmuchmail.org>
List-Unsubscribe: <http://notmuchmail.org/mailman/options/notmuch>,
	<mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://notmuchmail.org/pipermail/notmuch>
List-Post: <mailto:notmuch-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org>
List-Help: <mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=help>
List-Subscribe: <http://notmuchmail.org/mailman/listinfo/notmuch>,
	<mailto:notmuch-request-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org?subject=subscribe>
Sender: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Errors-To: notmuch-bounces-gxuj+Tv9EO5zyzON3hdc1g@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140767>

Hi,

On Tue, Feb 23, 2010 at 11:42 AM, Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org> wrote:
> FWIW, I only said "_at least_ you need consent from them", and it was not
> meant to be an exhaustive list. =A0"blame -C -C -C" may tell you more.

Without substantial analysis, "blame" alone is not sufficient - it
does not show which work was original, or derivative.

-- =

Cheers,
Ray Chuan
