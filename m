From: Charles Bailey <charles@hashpling.org>
Subject: Re: Apple violating git LGPL?
Date: Wed, 6 Aug 2014 19:36:35 +0100
Message-ID: <20140806183635.GA19596@hashpling.org>
References: <CAC_jL3wO9jkE4HapvJjn-4uW4RtSxubFthrxzQJ87EQ4Gq-9Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert P Fischer <rpf2116@columbia.edu>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:39:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF67a-00046S-As
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 20:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724AbaHFSja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 14:39:30 -0400
Received: from avasout05.plus.net ([84.93.230.250]:54574 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289AbaHFSj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 14:39:29 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout05 with smtp
	id bWfT1o0032iA9hg01WfUkP; Wed, 06 Aug 2014 19:39:28 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=fbAjyigF c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=7zjaaImrlgYA:10 a=RpdmVb4Y4xMA:10
 a=mSBy96HJJ2wA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=t-IPkPogAAAA:8
 a=sYnde1nURxW3ReH_WeUA:9 a=CjuIK1q_8ugA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1XF64h-000599-8I; Wed, 06 Aug 2014 19:36:35 +0100
Content-Disposition: inline
In-Reply-To: <CAC_jL3wO9jkE4HapvJjn-4uW4RtSxubFthrxzQJ87EQ4Gq-9Ug@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254888>

On Wed, Aug 06, 2014 at 02:10:08PM -0400, Robert P Fischer wrote:
> 
> 3. The version of git I ran is clearly NOT a plain vanilla "official"
> git, it is a derivative work.  Has Apple provided the source code of
> the special version that I just ran?  If not, that would seem to be a
> violation of the LGPL.

I found the source code of Apple's Git builds here:

http://www.opensource.apple.com/source/Git/

Mine happens to be Git-48. I'm not sure how to tell what version you
have if it is prompting you to accept a licence first.

Charles.
