From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: markdown 2 man, was Re: Git Community Book
Date: Wed, 30 Jul 2008 17:13:43 -0700
Message-ID: <d411cc4a0807301713o6b1fd2e8lde0636352f8f1c5b@mail.gmail.com>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
	 <20080729170955.GK32184@machine.or.cz>
	 <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
	 <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
	 <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>
	 <alpine.LSU.1.00.0807301514280.3486@wbgn129.biozentrum.uni-wuerzburg.de>
	 <7vy73j418t.fsf@gitster.siamese.dyndns.org>
	 <B7697630-DF9C-4EF0-9D63-9E362CEE125B@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git list" <git@vger.kernel.org>
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:14:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOLoj-0006ch-Lm
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 02:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbYGaANr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2008 20:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758345AbYGaANq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 20:13:46 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:30662 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762854AbYGaANo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2008 20:13:44 -0400
Received: by rv-out-0506.google.com with SMTP id k40so285494rvb.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 17:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=O58sgTZnlFFWLy9QynOBJDFszY0kcTGQxWz44ZjajYQ=;
        b=eoiTPI7WDuI6hsFpotroH8fOlLJMNsowa3BOwcsZb+GUDSqV0d0qBYLmgFRTM+c0Wb
         xGOI2qju8hsWTTSgDL383nuq9rtbq0ZlsvD09B0Qc38qCcZaTtFC6vBH7ukO1NbvySRL
         /nn2rKQfrOTPaphKIgArviF1oVaKJ1BULNf70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LNii6MtwiBZpqLWlrxvpDcpRwuRbC0o6nb1yhv51EjsbmOyafpSuutzD2Yx/7H0ysm
         AIpgCeQRe3PAO/52qckk1B/l9YtZYQh06pEAMVucqPIBaqa207NTV+P/81yNmvBbHQwW
         sgDeMVoOpiTpRGoRaut9zDmyKrK585TV3xDDM=
Received: by 10.114.53.18 with SMTP id b18mr6058057waa.141.1217463223958;
        Wed, 30 Jul 2008 17:13:43 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Wed, 30 Jul 2008 17:13:43 -0700 (PDT)
In-Reply-To: <B7697630-DF9C-4EF0-9D63-9E362CEE125B@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90883>

On Wed, Jul 30, 2008 at 4:48 PM, Wincent Colaiuta <win@wincent.com> wro=
te:
> El 30/7/2008, a las 21:32, Junio C Hamano escribi=F3:
>
>> That's one valid approach.  I or you might have taken a different av=
enue,
>> but after all, it's his book, not mine, not yours, nor git list's bo=
ok.
>
> Funnily enough, he chose to title it the "Git Community Book". Hard t=
o match
> Scott's enthusiasm; this is the second major initiative we've seen fr=
om him
> in the last few days (the other being git-scm.com itself) which to th=
e
> casual onlooker might look like the "official" Git homepage and
> documentation, but in both cases development occurred behind the scen=
es and
> the list was only notified after the fact. Better late than never I s=
uppose.

Not sure what else I could have done - I announced that I was starting
a documentation project like this about a week ago on this list, then
I started the book 3 days ago
(http://github.com/schacon/gitscm/commits/book) and announced it here
for initial review yesterday.  I haven't told very many people about
it yet and I haven't linked to it from git-scm.com yet either.  It's
been open source from the first minute on GitHub, and the link to the
source was on the website I posted here.

Same for the git-scm site - I started it on the 23rd and emailed Pasky
about it the next day, and the day after that he began submitting
patches to me for it and I announced it on this list.  Am I missing
something here?  Do you think I've been working on these secretly for
months, or something?  If there is a better communication workflow, I
would be happy to do so.

I appreciate that you notice my enthusiasm, though. :)

Scott



>> We originally hoped (well, at least I did) that Scott's effort on hi=
s book
>> might help us in improving the User Manual as well, but the approach=
 seems
>> to make it unlikely.  But that is nothing to hold against him --- he=
 is
>> doing his own thing in a way he feels is the best, and that's perfec=
tly
>> fine.  We lost nothing, perhaps except for a chance to cooperate a b=
it
>> better and to widen the community.
>
> Even though there might not be an automated way to get changes back f=
rom the
> fork, if there are clear improvements made then there is at least no =
legal
> obstacle to incorporating them back in, the only obstacle would be ti=
me and
> willingness to do so manually.
>
>>
> Cheers,
> Wincent
>
>
