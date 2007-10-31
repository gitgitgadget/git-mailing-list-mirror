From: Aidan Van Dyk <aidan@highrise.ca>
Subject: Re: Problem with git-cvsimport
Date: Wed, 31 Oct 2007 08:40:29 -0400
Organization: Highrise Community Network
Message-ID: <fg9t3t$kc3$1@ger.gmane.org>
References: <470B491F.9020306@jentro.com> <F1176033-1C6E-43F3-9F47-3BDD5EC88A14@orakel.ntnu.no> <170fa0d20710301306o6b3798f9k72615eb811d871f2@mail.gmail.com> <200710302244.50034.robin.rosenberg.lists@dewire.com>
Reply-To: dev@rapidsvn.tigris.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: dev@rapidsvn.tigris.org
X-From: dev-return-1233-gcvsrd-dev=m.gmane.org@rapidsvn.tigris.org Wed Oct 31 14:15:18 2007
Return-path: <dev-return-1233-gcvsrd-dev=m.gmane.org@rapidsvn.tigris.org>
Envelope-to: gcvsrd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1InDPi-0005o8-3e
	for gcvsrd-dev@gmane.org; Wed, 31 Oct 2007 14:15:18 +0100
Received: (qmail 19886 invoked by uid 5000); 31 Oct 2007 13:15:06 -0000
Mailing-List: contact dev-help@rapidsvn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@rapidsvn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@rapidsvn.tigris.org>
list-post: <mailto:dev@rapidsvn.tigris.org>
Delivered-To: mailing list dev@rapidsvn.tigris.org
Received: (qmail 19876 invoked from network); 31 Oct 2007 13:15:06 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAADscKEdQW+UCh2dsb2JhbACOZAIBCAop
X-IronPort-AV: E=Sophos;i="4.21,351,1188802800"; 
   d="scan'208";a="72020699"
X-IRONPORT: SCANNED
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: trb229.travel-net.com
User-Agent: KNode/0.10.5
Sender: news <news@ger.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62826>

Robin Rosenberg wrote:

> I use fromcvs which is *very* fast, and quite memory conservative compared
> to the others and seems reliable so far (six months). It probably breaks
> on exotic variants of branches though, but I don't have those / don't care
> about them.

I actually use fromcvs for a few repositories, and actually started using it
on repositories where cvsps (and git-cvsimport) fail.

> Drawbacks, more dependencies and access to the rcs files is required and
> tags are not converted.

Most projects have "rsyncs" or "tarballs" of their CVS repository available,
making fromcvs possible on most of them.  And CVS tags, well they are about
as good as CVS $Keywords$.
