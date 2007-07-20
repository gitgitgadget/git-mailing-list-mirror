From: Markus Schiltknecht <markus@bluegap.ch>
Subject: Re: CVS -> SVN -> Git
Date: Fri, 20 Jul 2007 10:45:50 +0200
Message-ID: <46A0763E.1070402@bluegap.ch>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>	 <469804B4.1040509@alum.mit.edu>	 <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>	 <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>	 <46994BDF.6050803@alum.mit.edu> <20070715013949.GA20850@thyrsus.com> <46a038f90707151805j454b57fbvb4d7ed526e1e64ce@mail.gmail.com> <469FB80A.8000001@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>, esr@thyrsus.com,
  Michael Haggerty <mhagger@alum.mit.edu>,
  Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
  dev <dev@cvs2svn.tigris.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: dev-return-2073-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Fri Jul 20 10:46:17 2007
Return-path: <dev-return-2073-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IBo7q-0002Kk-Aa
	for gcvscd-dev@gmane.org; Fri, 20 Jul 2007 10:46:14 +0200
Received: (qmail 25328 invoked by uid 5000); 20 Jul 2007 08:46:12 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 25318 invoked from network); 20 Jul 2007 08:46:12 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CACYToEZYxjr4/2dsb2JhbAA
X-IronPort-AV: i="4.16,562,1175497200"; 
   d="scan'208"; a="62527417:sNHT31466330"
X-IRONPORT: SCANNED
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <469FB80A.8000001@fs.ei.tum.de>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53072>

Simon 'corecode' Schubert wrote:
> I do not think Eric is right here.  You will allways lose information 
> when converting CVS to svn, and if it is just the uncertainty, the 
> non-atomicity.  This is also information (hidden one, though).

Full ACK.

> Yes.  I've already done what people want, it is not called cvs2xxx, but 
> fromcvs [1].  I don't think it is necessary to define an output format.  
> Of course, that's possible, but limiting yourself to a file format means 
> you're losing flexibility, which is needed for efficient, correct and 
> fast repository conversion.

Hm.. interesting. I'll have a close look.

Regards

Markus
