From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Allow to quickly go to a specific commit
Date: Sun, 17 May 2015 14:24:42 +1000
Message-ID: <20150517042442.GE21039@iris.ozlabs.ibm.com>
References: <1429114697-15926-1-git-send-email-ismael@iodev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ismael Luceno <ismael@iodev.co.uk>
X-From: git-owner@vger.kernel.org Sun May 17 08:36:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtsB7-0004ic-1C
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 08:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbbEQGft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 02:35:49 -0400
Received: from ozlabs.org ([103.22.144.67]:33596 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbbEQGfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 02:35:48 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id E02C01409F8; Sun, 17 May 2015 16:35:46 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <1429114697-15926-1-git-send-email-ismael@iodev.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269212>

On Wed, Apr 15, 2015 at 01:18:17PM -0300, Ismael Luceno wrote:
> Binds "g" to focus the sha1 entry box.
> 
> Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>

Thanks, applied (with some tweaks to the commit title and message).

Paul.
