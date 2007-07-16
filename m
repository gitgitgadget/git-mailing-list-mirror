From: Karl Fogel <kfogel@red-bean.com>
Subject: Re: CVS -> SVN -> Git
Date: Sun, 15 Jul 2007 18:30:17 -0700
Message-ID: <873azpqgnq.fsf@red-bean.com>
References: <Pine.LNX.4.64.0707131541140.11423@reaper.quantumfyre.co.uk>
	<469804B4.1040509@alum.mit.edu>
	<46a038f90707132230n120e6392uaf5cd86ff10b6012@mail.gmail.com>
	<4699034A.9090603@alum.mit.edu> <20070714195252.GB11010@thyrsus.com>
	<46994BDF.6050803@alum.mit.edu>
	<7154c5c60707141623s3f70e967s226e5da29965a173@mail.gmail.com>
	<469A099E.6060906@alum.mit.edu>
	<46a038f90707151808u67c4e834lb06ed86c855f58ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael Haggerty" <mhagger@alum.mit.edu>,
	  "David Frech" <david@nimblemachines.com>,  esr@thyrsus.com,
	  "Julian Phillips" <julian@quantumfyre.co.uk>,  git@vger.kernel.org,
	  dev <dev@cvs2svn.tigris.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: dev-return-2063-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org Mon Jul 16 03:30:30 2007
Return-path: <dev-return-2063-gcvscd-dev=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscd-dev@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IAFPv-0006Ma-Kf
	for gcvscd-dev@gmane.org; Mon, 16 Jul 2007 03:30:28 +0200
Received: (qmail 16904 invoked by uid 5000); 16 Jul 2007 01:30:24 -0000
Mailing-List: contact dev-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:dev-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:dev-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:dev@cvs2svn.tigris.org>
Delivered-To: mailing list dev@cvs2svn.tigris.org
Received: (qmail 16893 invoked from network); 16 Jul 2007 01:30:24 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAH5mmkZCksE9kmdsb2JhbACPPwEBAgcEBg4Z
X-IronPort-AV: i="4.16,540,1175497200"; 
   d="scan'208"; a="77367357:sNHT16701853"
X-IRONPORT: SCANNED
Mail-followup-to: dev@cvs2svn.tigris.org
In-Reply-To: <46a038f90707151808u67c4e834lb06ed86c855f58ec@mail.gmail.com> (Martin Langhoff's message of "Mon\, 16 Jul 2007 13\:08\:09 +1200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52620>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:
> On 7/15/07, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> > It took a day and half to get the svn dump parsing right (it's an
>> > egregiously bad format) but only a couple of hours to write the
>> > fast-import backend.
>>
>> I'm surprised you think that; I find the svn dump format quite easy and
>> straightforward.  (Of course it assumes some Subversionisms, like easy
>> deep directory copies, which I can imagine would be annoying in other
>> contexts.)  What don't you like about the format?
>
> Is there good doco and samples for it? I wouldn't mind doing things by
> way of an SVN dump parser.

   http://svn.collab.net/repos/svn/trunk/notes/dump-load-format.txt

Best,
-Karl
