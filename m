From: Bill Lear <rael@zopyra.com>
Subject: Re: [PATCH 2/2] Heavily expanded update hook to send more useful emails than the old hook
Date: Fri, 26 Jan 2007 08:45:07 -0600
Message-ID: <17850.5107.985027.629049@lisa.zopyra.com>
References: <29b04c45a795406bd9b278eb44321fe572dc8adf.1169801884.git.andyparkins@gmail.com>
	<200701260901.04813.andyparkins@gmail.com>
	<7vejpi17e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	"Deepak Barua" <dbbarua@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 15:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HASKM-0003Y6-44
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 15:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbXAZOpO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 09:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030606AbXAZOpO
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 09:45:14 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60610 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030533AbXAZOpN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 09:45:13 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0QEj8722070;
	Fri, 26 Jan 2007 08:45:08 -0600
In-Reply-To: <7vejpi17e3.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37863>

On Friday, January 26, 2007 at 01:09:40 (-0800) Junio C Hamano writes:
>I've been wondering if we would want to have example-hooks/
>directory (not necessarily under contrib/).  Different people
>seem to want different things from the hooks and I'd like to
>avoid "my version is better than yours" arms race to result in
>unnecessary bloat of example hooks that are copied to every
>repository but yet left disabled.

I think this is independent of providing a good (configurable)
default hook, though.  That effort should continue, I believe.


Bill
