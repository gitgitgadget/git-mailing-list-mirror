From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major
 bugs.
Date: Wed, 2 Jan 2013 11:41:07 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130102164107.GA19006@thyrsus.com>
References: <20130101172645.GA5506@thyrsus.com>
 <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com>
 <20130102080247.GA20002@elie.Belkin>
 <20130102105919.GA14391@thyrsus.com>
 <20130102153933.GA30813@elie.Belkin>
 <20130102161848.GA18447@thyrsus.com>
 <CACPiFCKDoAoKxM4YU6uKoOGcDgLbXnCoUMO5iyf-wCWXh3j70A@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 17:42:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRON-0006yr-JS
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 17:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961Ab3ABQlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 11:41:53 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:36451
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab3ABQlw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 11:41:52 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 622AA4415C; Wed,  2 Jan 2013 11:41:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACPiFCKDoAoKxM4YU6uKoOGcDgLbXnCoUMO5iyf-wCWXh3j70A@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212523>

Martin Langhoff <martin.langhoff@gmail.com>:
> Replacement with something more solid is welcome, but until you are
> extremely confident of its handling of legacy setups... I would still
> provide the old cvsimport, perhaps in contrib.

I am extremely confident.  I built a test suite so I could be.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
