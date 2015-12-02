From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V3] git-send-email: Add auto-cc to all body signatures
Date: Wed, 02 Dec 2015 10:28:58 -0800
Message-ID: <1449080938.3716.45.camel@perches.com>
References: <b2937bc06d1bff456b84e51d6edee0bb1afc5f31.1311902983.git.joe@perches.com>
	 <1311903782.20837.42.camel@jtkirshe-mobl>
	 <1323313119.1762.58.camel@joe2Laptop>
	 <7v8vmmj1ng.fsf@alter.siamese.dyndns.org>
	 <1323377486.1762.71.camel@joe2Laptop> <87mvtti2ul.fsf@rasmusvillemoes.dk>
	 <1449075602.3716.27.camel@perches.com>
	 <xmqq8u5c68by.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org,
	jeffrey.t.kirsher@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:29:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4C9i-0006aC-Ay
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 19:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759267AbbLBS3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2015 13:29:24 -0500
Received: from smtprelay0246.hostedemail.com ([216.40.44.246]:56574 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759250AbbLBS3C (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2015 13:29:02 -0500
Received: from filter.hostedemail.com (unknown [216.40.38.60])
	by smtprelay03.hostedemail.com (Postfix) with ESMTP id CF38D6AA83;
	Wed,  2 Dec 2015 18:29:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:541:599:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1536:1559:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3867:4321:5007:6261:6642:7904:10004:10400:10848:11658:11914:12109:12517:12519:12740:13069:13311:13357:13894:14659:21080:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: earth12_88bffa990f11a
X-Filterd-Recvd-Size: 1299
Received: from joe-X200MA.home (pool-173-51-221-2.lsanca.fios.verizon.net [173.51.221.2])
	(Authenticated sender: joe@perches.com)
	by omf05.hostedemail.com (Postfix) with ESMTPA;
	Wed,  2 Dec 2015 18:28:59 +0000 (UTC)
In-Reply-To: <xmqq8u5c68by.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.2-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281900>

On Wed, 2015-12-02 at 09:58 -0800, Junio C Hamano wrote:
> "Trailers" are not limited to "*-by:"

btw: =A0what are "Trailers" limited by?
