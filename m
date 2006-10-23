From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 20:21:53 +0200
Message-ID: <200610232021.55625.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <200610231953.19605.jnareb@gmail.com> <Pine.LNX.4.64.0610231103460.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 20:22:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc4Qg-0000Te-RB
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 20:21:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWJWSVj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 14:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWJWSVj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 14:21:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:43890 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964995AbWJWSVg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 14:21:36 -0400
Received: by ug-out-1314.google.com with SMTP id q2so1464273uge
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 11:21:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EGnsey7up1FpTw6c5AlH70+U49Frs47QtPdY0FVFnYP0d3ITRqJXD24L7qMpAc29mpBS8PzUIsW7xgMmdMPEbDFsprSSVseqm/OPAb7aC5ShGTZqVYH+FgVomfT4uSSzuL6QpzSxQpZWak2LdvaymZxJ+psYP2kytT1ZrwWT7N4=
Received: by 10.67.27.3 with SMTP id e3mr7811189ugj;
        Mon, 23 Oct 2006 11:21:35 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id x37sm1221258ugc.2006.10.23.11.21.34;
        Mon, 23 Oct 2006 11:21:35 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0610231103460.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29853>

Linus Torvalds wrote:
> 
> On Mon, 23 Oct 2006, Jakub Narebski wrote:
>> 
>> Besides, you need [constant] network access for this mapping.
> 
> I _think_ that Aaron was trying to say that
> 
> 	abentley@panoramicfeedback.com-20060927202832-9795d0528e311e31
> 
> is always constant, so you can use that.
> 
> Of course, nobody will ever do that, because in practice they're not 
> shown, the same way the "true" BK revision names were never shown and thus 
> never really used.

By the way, I wonder if accidentally identical revisions
(see example for accidental clean merge on revctrl.org)
would get the same revision id in bzr. In git they would.
-- 
Jakub Narebski
Poland
