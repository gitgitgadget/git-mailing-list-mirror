From: FernandoBasso <FernandoBasso.br@gmail.com>
Subject: Re: Really beginner on Version Control
Date: Wed, 22 Sep 2010 04:45:43 -0700 (PDT)
Message-ID: <1285155943433-5558696.post@n2.nabble.com>
References: <1285080133451-5555023.post@n2.nabble.com> <m3mxrak937.fsf@localhost.localdomain> <1285114417273-5557145.post@n2.nabble.com> <1AF8A1BC-1E52-4385-A0FC-16A04B4724FF@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 22 13:45:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyNlm-0004ug-Pz
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 13:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417Ab0IVLpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 07:45:44 -0400
Received: from kuber.nabble.com ([216.139.236.158]:41946 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab0IVLpo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 07:45:44 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <FernandoBasso.br@gmail.com>)
	id 1OyNlf-0006hC-EH
	for git@vger.kernel.org; Wed, 22 Sep 2010 04:45:43 -0700
In-Reply-To: <1AF8A1BC-1E52-4385-A0FC-16A04B4724FF@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156799>


 On 09/22/2010 12:52 AM, Andrew Keller wrote:
> The only thing is, in your example, since master did not progress since
> testing diverged, 
> git simply thinks of it as being "behind" testing...



You have used the word 'behind'. I think 'time' what is making me fail to
understand git merging. It depends on which branch I have changed last. Not
only if I changed the same line in both branches. If I change (same line)
the master, commit. Change testing commit. Merge testing into master, they
will not conflict because master haven't changed since testing changed.
Master is "behind" testing.

-- 
View this message in context: http://git.661346.n2.nabble.com/Really-beginner-on-Version-Control-tp5555023p5558696.html
Sent from the git mailing list archive at Nabble.com.
