From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Idea for Git Bugtracking Tool
Date: Sat, 8 Mar 2008 15:23:13 +0100
Message-ID: <200803081523.14340.jnareb@gmail.com>
References: <20080306142246.5d9460b7@gmail.com> <m3zltaf7vs.fsf@localhost.localdomain> <20080308134210.GA3230@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Harning <harningt@gmail.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 15:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXzy7-0003L5-CX
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 15:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbYCHOXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Mar 2008 09:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbYCHOXR
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 09:23:17 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:55552 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbYCHOXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 09:23:16 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1067037fga.17
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 06:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=eUP8iOyV4hUKl7CwjUp/FRPsIkEhioLVwL/EsGCjk0k=;
        b=hJBF7lTsXFZI15Ie5cHvTdMClkoV8DT5ooOhDadai83hSpQjwpV7GEAfq569m173+Mn5FtXsAWt/UQgfVHtBozjmWRyUTyRQiLjv255gJaekj+Sy+Iopycu9EQLNm3s8ei+JfquFxJ7vcB6kCWmok5YACNs6aqaA5n19ZcDSkBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=csuAJgQ+1y87wO2PpmdaNGeCZzkPJdo5OjvTp2tpZ5039RvoheJsNCfoaSd3ALv59CMZs57IjGT3TqHzUhyU1BEFXK8BXjkLHE3+byCFFOEw3kjPZ559txV/pgYzbas4aPdzulDR1gMWU0C5rQJfVA3JSpUhkZ7iMKT/z6rQ2vQ=
Received: by 10.86.80.5 with SMTP id d5mr3235464fgb.20.1204986195345;
        Sat, 08 Mar 2008 06:23:15 -0800 (PST)
Received: from ?192.168.1.15? ( [83.8.243.158])
        by mx.google.com with ESMTPS id 12sm5949252fgg.6.2008.03.08.06.23.12
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Mar 2008 06:23:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20080308134210.GA3230@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76563>

Dnia sobota 8. marca 2008 14:42, Pierre Habouzit napisa=B3:
> On Fri, Mar 07, 2008 at 11:10:18PM +0000, Jakub Narebski wrote:
>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>=20
>>> Thomas Harning <harningt@gmail.com> writes:
>>>=20
>>>> Any ideas/flaws with this concept?  Anybody up for taking on this
>>>> project... or for taking this up as a GSOC project mentor?
>>>=20
>>> Already discussed here:
>>>=20
>>> http://thread.gmane.org/gmane.comp.version-control.git/48981/
>>>=20
>>> Pierre Habouzit started working on something called grit, which
>>> seems to be dead.
>>=20
>> Pierre, what happened to git://git.madism.org/grit.git ?
>=20
>   it was very badly coded, and not going in the proper direction.

Should it be then removed from InterfacesFrontendsAndTools wiki page
(perhaps putting "Bugs Everywhere", with Git as one of supported versio=
n
control backends in its place)?

> We discussed design with Dscho a couple of time, I know how to build
> such a tool in git (at least a bit how) but I never found the time.

Care to share those thoughts, and what mistakes were made?

--=20
Jakub Narebski
Poland
