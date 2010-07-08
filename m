From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: What's cooking in git.git (Jul 2010, #01; Wed, 7)
Date: Thu, 8 Jul 2010 14:27:16 +0200
Message-ID: <20100708122716.GA2193@pvv.org>
References: <7vlj9msve4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 14:27:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWqCN-0005V8-5u
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 14:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921Ab0GHM1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 08:27:20 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:46713 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513Ab0GHM1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 08:27:20 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OWqCC-0002K7-6H; Thu, 08 Jul 2010 14:27:16 +0200
Content-Disposition: inline
In-Reply-To: <7vlj9msve4.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150569>

On Wed, Jul 07, 2010 at 04:51:47PM -0700, Junio C Hamano wrote:

> * eb/double-convert-before-merge (2010-07-02) 3 commits
>  - Don't expand CRLFs when normalizing text during merge
>  - Try normalizing files to avoid delete/modify conflicts when merging
>  - Avoid conflicts when merging branches with mixed normalization

Any hopes of getting this in soonish? Since this now is "opt-in", and
helps tremendously if you are adding the new text/eol attributes, it
would be helpful to see it in the same release as the new attributes.

- Finn Arne
