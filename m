From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Thu, 24 Feb 2011 04:45:52 -0600
Message-ID: <20110224104552.GD14115@elie>
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
X-From: git-owner@vger.kernel.org Thu Feb 24 11:46:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsYhx-00079Q-0z
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 11:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560Ab1BXKqA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 05:46:00 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59716 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab1BXKp7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 05:45:59 -0500
Received: by vxi39 with SMTP id 39so301638vxi.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 02:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pjSDQBMgVO9FU/usYiLMOjCJHObKeKahyLZ/bWA1P24=;
        b=usNqxXxtWs+mfIGDrCKpCPyyYN5vjEipeEw/8R7CnUTcFB5WMCiRDPK2pC8Z11v8mY
         GKKnAfJcThz3/ik7qfFNqvA86SC9FzlaZPvwYtTEtAuBga4tqO0v/PSD/ftgwlFWloK/
         mx6VBTUyFvXwBi+7zyDq2JNkYzt7NuvKMutNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=o9rJJD1CYzAL2N+KAJTqCmHjVRZS5L7BH9y5J+zY3ql+IUOr9DlNfgVw9SL217r+n4
         jqUUpAYuVQYR7+ZeCQa7ArSTYl3OowN9o0wKdpbSPYmkK11+eU2TyK8AfrTZukuMrxzR
         qktjnrPaP3tFFW6af4SCjC5r4caNU/TZrEy9c=
Received: by 10.52.158.136 with SMTP id wu8mr1123938vdb.218.1298544357832;
        Thu, 24 Feb 2011 02:45:57 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id n13sm4145760vcr.41.2011.02.24.02.45.56
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 02:45:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikfqmPKA0T4Q-ac0CXzqmCEp0cWNskODEjmACW_@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167798>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I don't mean it that way at all, I just mean that as a comment to
> *this* particular patch series I don't think it's something we have t=
o
> worry about.

Then we're in violent agreement, I suppose.  I don't think anyone
meant to imply that rot13 or anything of the kind should be snuck in
here.  Rereading my message, I see how it can be read that way ---
sorry about that.

I had only meant to give a heads up about something coming in the
future.
