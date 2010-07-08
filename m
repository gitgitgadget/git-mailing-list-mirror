From: Eli Barzilay <eli@barzilay.org>
Subject: Re: gitweb.css
Date: Thu, 8 Jul 2010 15:30:39 -0400
Message-ID: <19510.10079.395353.55808@winooski.ccs.neu.edu>
References: <19509.15171.909921.769184@winooski.ccs.neu.edu>
	<201007082049.23550.jnareb@gmail.com>
	<19510.8063.606085.233114@winooski.ccs.neu.edu>
	<201007082125.59544.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:30:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwo1-0005zQ-4d
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758501Ab0GHTal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:30:41 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:50406 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756914Ab0GHTak (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 15:30:40 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OWwnv-0001VW-D8; Thu, 08 Jul 2010 15:30:39 -0400
In-Reply-To: <201007082125.59544.jnareb@gmail.com>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150602>

On Jul  8, Jakub Narebski wrote:
> 
> No, what I meant here is that the structure of gitweb page should look
> like the following, in pseudocode: [...]

Ah -- dividing the gitweb content to header/content/footer -- that
makes perfect sense.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
