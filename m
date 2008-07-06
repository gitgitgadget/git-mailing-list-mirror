From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 6 Jul 2008 13:10:06 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807061309140.32725@wbgn129.biozentrum.uni-wuerzburg.de>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org> <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org>
 <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 13:11:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFS95-00062P-Te
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 13:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbYGFLKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 07:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbYGFLKK
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 07:10:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:32811 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751912AbYGFLKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 07:10:09 -0400
Received: (qmail invoked by alias); 06 Jul 2008 11:10:07 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp061) with SMTP; 06 Jul 2008 13:10:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ooWpcev5oKVzvMnHbRNFfzBssBPc2aBbEnJ/1NU
	2pq5jCafog1qND
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87515>

Hi,

On Sun, 6 Jul 2008, Junio C Hamano wrote:

> * js/apply-root (Wed Jul 2 15:28:22 2008 -0700) 2 commits
>  + apply --root: thinkofix.
>  + Teach "git apply" to prepend a prefix with "--root=<root>"

If we want to call this "--directory=<root>" instead, we should do it 
before that commit hits master.

Ciao,
Dscho
