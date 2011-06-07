From: Philippe De Muyter <phdm@macqel.be>
Subject: Re: git fast-export and lightweight tags
Date: Tue, 7 Jun 2011 16:33:21 +0200
Message-ID: <20110607143321.GA18671@frolo.macqel>
References: <20110607110213.GA2698@frolo.macqel> <BANLkTikiNeufjH30HeApW6-71T2vOpKrxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 16:33:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTxLX-0006ql-P5
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 16:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783Ab1FGOd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 10:33:26 -0400
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:3030 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755667Ab1FGOdZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 10:33:25 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAGE07k3CTtAn/2dsb2JhbABTphx3ylmGIQSRCo9H
Received: from smtp2.macqel.be ([194.78.208.39])
  by relay.skynet.be with ESMTP; 07 Jun 2011 16:33:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by smtp2.macqel.be (Postfix) with ESMTP id 92CEE130DD7;
	Tue,  7 Jun 2011 16:33:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at macqel.be
Received: from smtp2.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dkjt8Pxvebbt; Tue,  7 Jun 2011 16:33:22 +0200 (CEST)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by smtp2.macqel.be (Postfix) with ESMTP id 0BC79130A5E;
	Tue,  7 Jun 2011 16:33:22 +0200 (CEST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
	id E69EBDF08FD; Tue,  7 Jun 2011 16:33:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikiNeufjH30HeApW6-71T2vOpKrxQ@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175208>

Hi Sverre,

On Tue, Jun 07, 2011 at 04:10:45PM +0200, Sverre Rabbelier wrote:
> Heya,
> 
> On Tue, Jun 7, 2011 at 13:02, Philippe De Muyter <phdm@macqel.be> wrote:
> > How can I convince fast-export to export my tags ?
> 
> Untested, this is just from memory:
> 
> $ git fast-export --all --tags

Yes, that works, but neither

$ git help fast-export

nor

$ git fast-export

does mention it :(

Thanks

Philippe

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
