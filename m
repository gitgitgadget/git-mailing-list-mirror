From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sun, 05 Sep 2010 03:43:38 +0200
Message-ID: <4C82F5CA.2080502@dbservice.com>
References: <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org> <alpine.LFD.2.00.1009031522590.19366@xanadu.home> <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu> <alpine.LFD.2.00.1009040040030.19366@xanadu.home> <5B5470E5-57E6-48D2-981B-CE77FA43546F@mit.edu> <AANLkTi==yv2CkgKEPJbTLf0P2XMtLmny1t6Zqhwh8wbV@mail.gmail.com> <20100904181405.GB4887@thunk.org> <m3tym5mfce.fsf@localhost.localdomain> <AANLkTimhCi2vWWnHGwT5ToRtFbjkxTgVYVvYLR3UCb2S@mail.gmail.com> <20100904224726.GE4887@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ted Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 05 03:44:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os4HD-0001QK-KO
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 03:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab0IEBnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 21:43:53 -0400
Received: from office.neopsis.com ([78.46.209.98]:56135 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab0IEBnw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 21:43:52 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.062,BAYES_00: -1.665,TOTAL_SCORE: -1.603,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sun, 5 Sep 2010 03:43:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <20100904224726.GE4887@thunk.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155407>

On 9/5/10 12:47 AM, Ted Ts'o wrote:
> hard?  For bonus points it could register with Avahi (i.e., the
> Zeroconf protocol), which would make it easier to set up adhoc sharing
> arrangements.  But if that's your goal, I'd suggest making "git

http://github.com/toolmantim/bananajour, and there's another project
with similar goals, but I forgot its name and can't find it right now.

tom
