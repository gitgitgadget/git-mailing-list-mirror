From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Thu, 24 Feb 2011 05:00:29 -0600
Message-ID: <20110224110029.GE14115@elie>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
 <20110223234828.GA7286@elie>
 <7vd3mi44gx.fsf@alter.siamese.dyndns.org>
 <AANLkTinY4pt5DLokKkuCNnC1yi7nQBHcZv722x9CKvCh@mail.gmail.com>
 <20110224031414.GC7970@elie>
 <AANLkTikfqmPKA0T4Q-ac0CXzqmCEp0cWNskODEjmACW_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 12:00:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsYw5-0005cJ-0t
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 12:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598Ab1BXLAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 06:00:36 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48315 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab1BXLAf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 06:00:35 -0500
Received: by vxi39 with SMTP id 39so309311vxi.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 03:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=f29p5cwN1tsiDsT8DZ209u9NVV9iy2u88tzIz0ggWMQ=;
        b=q2REVwGIdxQj1zWcA4jkf1JtaigwXdBpZgXtNsUFUvqxT3/d8zcSx9x+qLNStZ6aqQ
         vurduml113FaHNYxTKVoW93wTUV3tntUSQzdSz5rUVkILM/tb76fbO0/BdZKwiqmk/9t
         nmVuqKl2KR2thXdqrbZzya50nXHq6YD+i6PP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WhYerpQi6DJk+jZNNUdRapLiLOcLGoxhEiP1kuXjMmnckhkGAfB9BiVysQiSCsIdwW
         WZgi/O0WlGG/IBzmgp0NEa3Iziy42MfWHKShCBDxjYJE/QvThHexYsQzPDA/vICQ3kL6
         nd5GaZ0D90/bd+KvsrYwGyKdGa5jR/bakxnSA=
Received: by 10.52.167.73 with SMTP id zm9mr1136567vdb.106.1298545234551;
        Thu, 24 Feb 2011 03:00:34 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id m10sm3044666vcs.8.2011.02.24.03.00.32
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 03:00:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikfqmPKA0T4Q-ac0CXzqmCEp0cWNskODEjmACW_@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167799>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I don't mean it that way at all, I just mean that as a comment to
> *this* particular patch series I don't think it's something we have t=
o
> worry about.

This is really tiring and unpleasant.  I don't want to stand in the
way of a translated git happening or to take on the project myself
so I can't just decree "it will be like so".

It's your and Junio's (and lots other people's, of course) code.  But
that means that for me to be able to help, I need to be able to say,
"here's a suggested change" and get an "okay" or "no, here's what's
wrong with that and how you can improve it".

And that just doesn't seem to be happening now.  I don't know how to
fix it, but I thought I should explain why I am probably so
frustrating to work with right now.

Sorry about that.
