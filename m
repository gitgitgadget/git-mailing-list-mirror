From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] cherry: cache patch-ids to avoid repeating work
Date: Wed, 9 Jul 2008 14:18:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807091416480.5277@eeepc-johanness>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com> <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org> <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com> <7vprpnlglh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geoffrey Irving <irving@naml.us>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 14:19:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGYdY-0004XG-GR
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 14:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbYGIMSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 08:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbYGIMSK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 08:18:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:59838 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750748AbYGIMSI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 08:18:08 -0400
Received: (qmail invoked by alias); 09 Jul 2008 12:18:07 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp022) with SMTP; 09 Jul 2008 14:18:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18yZmd3qmEySvy/E6o24jTF7vzqErdSkSU0c+bXPZ
	3NuEgzs3p66P0F
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vprpnlglh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87877>

Hi,

On Tue, 8 Jul 2008, Junio C Hamano wrote:

> Think of this procedure as giving a chance for you to hide early 
> embarrassment under the rug ;-)

Further, as Shawn pointed out to me (and you will all be able to hear it 
for yourselves soon), these patch iterations give you the chance to apply 
all the wisdom of the combined developers on this list to your patch, and 
in the end put your name on it :-)

Ciao,
Dscho
