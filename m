From: Sergei Organov <osv@javad.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Wed, 14 Nov 2007 17:13:30 +0300
Message-ID: <874pfo6hkl.fsf@osv.gnss.ru>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
	<7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
	<87myth58r5.fsf@osv.gnss.ru> <fhettp$rtk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 15:13:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsJ0A-0000Lv-39
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 15:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbXKNONm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 09:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbXKNONm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 09:13:42 -0500
Received: from javad.com ([216.122.176.236]:1866 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbXKNONl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 09:13:41 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lAEEDa076495;
	Wed, 14 Nov 2007 14:13:37 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IsIzi-00087i-54; Wed, 14 Nov 2007 17:13:30 +0300
In-Reply-To: <fhettp$rtk$1@ger.gmane.org> (Jakub Narebski's message of "Wed\, 14 Nov 2007 14\:41\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64986>

Jakub Narebski <jnareb@gmail.com> writes:

> Sergei Organov wrote:
>
>> Just a wild idea. Doesn't it make sense to introduce perfect ultimate
>> common ancestor of the universe, probably calling it "the NULL commit"?
>> At first glance it seems that it can help to avoid corner cases
>> automagically.
>
> No. Sometimes you want unrelated branches in repository ('html', 'man',
> 'todo' branches in git.git), sometimes multiple roots are natural (merging
> in a project, like git-mailtools, gitweb, gitk, git-gui in git.git).

Sorry, I fail to see how does it interfere with the idea of the NULL
commit. What if  "unrelated" is defined as "the only common
ancestor is the NULL commit"?

Anyway, I'm not going do defend the idea further. I just recalled I
heard about it somewhere, probably in Bazaar-NG, and I thought I'd
mention it here as it appeared very natural to me.

-- 
Sergei.
