From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [announce] gc
Date: Tue, 23 Dec 2008 15:06:24 +0000
Message-ID: <e2b179460812230706p12e4f052v960f162e08011ae6@mail.gmail.com>
References: <20081222212407.47c9ab1e.stephen@exigencecorp.com>
	 <vpqabanc9v6.fsf@bauges.imag.fr>
	 <20081223082207.f31ab2a3.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: "Stephen Haberman" <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 16:08:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF8rK-0001S6-2p
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 16:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbYLWPG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 10:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbYLWPG1
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 10:06:27 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:55810 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYLWPG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 10:06:26 -0500
Received: by qw-out-2122.google.com with SMTP id 3so1623796qwe.37
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 07:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2cHzBw2hYL1MGMen9Im22EqpiOPABfwkUdlQH9f4eWg=;
        b=ULpptCAoA8pXuJtL9jF++Pm11n5ogd4yE32Xs80hlq9WVD7RzN3jyT8o8oTu2oik5E
         eCnJMZA7pNJ0e4FEA4pIi2rrZOGTFhvFR/JIUr0rjY1ShE9rdRCrksu3DBu+qjy/LlBZ
         wGkRM6/vBGc0HOT8hbqXs0Meic1OR1odXWIQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EWLb/95uMgiVOy1E3cD0cQwI2bvRKjbvsKSVSi4BavxGHmoJjs7tt+4odRB36bBURL
         Tpc6GBlHTrFW/T6cJsHsNRgaxlf0cRiMpvya6oaFBowlvo3n+xWIE0A3uPmXyuclYlOd
         q28zXWlFEttA2d+k8XdhYlA+qwWKKIuPoHjus=
Received: by 10.214.130.2 with SMTP id c2mr1278792qad.159.1230044784939;
        Tue, 23 Dec 2008 07:06:24 -0800 (PST)
Received: by 10.214.150.9 with HTTP; Tue, 23 Dec 2008 07:06:24 -0800 (PST)
In-Reply-To: <20081223082207.f31ab2a3.stephen@exigencecorp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103827>

2008/12/23 Stephen Haberman <stephen@exigencecorp.com>
>
> > You should find a better name. I mean, one for which
> >
> >   http://www.google.com/search?q=git+YOUR-NAME-HERE
> >
> > has a chance to find you ...
>
> Ah, good point.
>
> Perhaps "git corporate hooks" or "git enterprise hooks".
>
> I'm a little cautious about using words like corporate/enterprise as
> there is nothing exclusively "corporate/enterprise" about any of the
> hooks in the project, we just happened to be on a corporate/enterprise
> project when we came up with them.

As the workflows these seem to support are centralised (as you say
these apply equally well in some non-corporate / enterprise projects),
how about git-central?

Mike
