From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] submodule+shallow clone feature request
Date: Thu, 11 Feb 2010 00:59:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002110057180.20986@pacific.mpi-cbg.de>
References: <4B73277C.9010801@columbia.edu> <7vsk983fi4.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1002102354010.20986@pacific.mpi-cbg.de> <7v1vgszo16.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Schuyler Duveen <sky@columbia.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 00:53:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfMNB-0001Uc-8e
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 00:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756212Ab0BJXx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 18:53:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:40018 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756053Ab0BJXx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 18:53:27 -0500
Received: (qmail invoked by alias); 10 Feb 2010 23:53:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 11 Feb 2010 00:53:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CdS9jGD9CzbuMtPOSi1IsQldeBClyVEFjQkcpIj
	T5wsWPfzohmNWv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v1vgszo16.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139569>

Hi,

On Wed, 10 Feb 2010, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Yes. Note, though, that the problems of enhancing git-submodule are 
> > not technical, as we can learn from the recent history, including the 
> > lack of support for rebasing submodules (there _were_ patches!).
> 
> Sorry I don't recall.  Were they of 'next' quality?  How well were they 
> reviewed?

Obviously not, otherwise you would have applied them, no?

OTOH I found the technical details rather trivial, so maybe they were 
'next' quality, but there was another reason you did not apply them.

I just know that from my daily workflow, I deeply miss rebasing 
submodules. But then, I listed the issues I have with submodules, and this 
list was welcomed with unbelievable enthusiasm.

Ciao,
Dscho
