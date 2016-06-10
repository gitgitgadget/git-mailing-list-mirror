From: Peter Colberg <peter@colberg.org>
Subject: Re: [PATCH v2] Fix spelling of "occurred"
Date: Fri, 10 Jun 2016 18:04:05 -0400
Message-ID: <20160610220405.GA19824@alcyone>
References: <CAFZEwPMgYCau=LxdtjZ2WVJXp91mXYG5bc=0X0mo_eJ+eYqLHA@mail.gmail.com>
 <1465585526-32187-1-git-send-email-peter@colberg.org>
 <xmqqd1noeodt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 00:14:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBUhW-00004w-Tq
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 00:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbcFJWEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 18:04:14 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:36823 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbcFJWEN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 18:04:13 -0400
Received: from [144.76.164.56] (helo=pleione.colberg.org)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <peter@colberg.org>)
	id 1bBUXA-0003Hd-Rz; Sat, 11 Jun 2016 00:04:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=colberg.org;
	s=20160215; t=1465596248;
	bh=/H3ezmS0WnEKpiSfUP369bF2X3N66F6psmii9NH5Xvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	b=g5KwqWUAjxBWml2COtm5zRmO98LEqExtehYMbd8eD+Yvf5HGqIroQkBMHNCIhG17H
	 RhM4MU9N0/gNKeUqEobsdMbodJfLaxEA9xeQ3Ct8LY+Z7aWMYcAI2nRaab7VaDYQ1/
	 vNuFnN5L9LxjKyb2mUSpfjFOVK43Qk6EOFrMLB7Norpwv7uulss0EYQ3oVHGPrj9eC
	 5L4mG4bobxmbRuD6rIrpqFiyPW+493N1bcGBaC5Kn9Xs3Gm1f2HO5pqDNUXqWBUhMp
	 V8VCYCILcfLmbOJMUIhK/8rMEiXry6DQNItyxEYcKIRTXxI66xXfAMA6lZjTGgJvSt
	 fXQpQFbOaez9Q==
Content-Disposition: inline
In-Reply-To: <xmqqd1noeodt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Df-Sender: MTAwMjE5OA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297079>

On Fri, Jun 10, 2016 at 02:15:58PM -0700, Junio C Hamano wrote:
> For this one, I am tempted to say that it may be better to remove
> the verb altogether, which would lead to a more concise error
> message.

Thanks, I will send [PATCH v3] when the next release cycle begins.

Peter
