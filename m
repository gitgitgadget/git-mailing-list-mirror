From: Oswald Buddenhagen <ossi@kde.org>
Subject: Re: CVS -> SVN -> Git
Date: Sat, 14 Jul 2007 23:50:31 +0200
Message-ID: <20070714215031.GA3833@ugly.local>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk> <469804B4.1040509@alum.mit.edu> <46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com> <4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	dev <dev@cvs2svn.tigris.org>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: dev-return-2042-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Sat Jul 14 23:50:40 2007
Return-path: <dev-return-2042-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1I9pVf-0001ld-Q4
	for gcvscd-dev@gmane.org; Sat, 14 Jul 2007 23:50:40 +0200
Received: (qmail 13863 invoked by uid 5000); 14 Jul 2007 21:50:35 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 13853 invoked from network); 14 Jul 2007 21:50:35 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAFrimEaD9nj6jWdsb2JhbACPNwEBAgcGBgkGHw
X-IronPort-AV: i="4.16,539,1175497200"; 
   d="scan'208"; a="62155235:sNHT17808840"
X-IRONPORT: SCANNED
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	dev <dev@cvs2svn.tigris.org>
Content-Disposition: inline
In-Reply-To: <20070714195252.GB11010@thyrsus.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52511>

On Sat, Jul 14, 2007 at 03:52:52PM -0400, Eric S. Raymond wrote:
> That being the case, two-step conversion with tools that import CVS to
> SVN and export from SVN to whatever actually works extremely well.
>
well, yes. hoooowever ... you are missing a few details:
- conversion time. until we have incremental conversions, this is
  absolutely critical to many organizations.
- psychology. cvs2xxx is simpler than cvs2svn + svn2xxx. it's also sort
  of a mindset thing. don't underestimate this.

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.
