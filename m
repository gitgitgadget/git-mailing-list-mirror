From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/2] Add config_boolean() method to the Git perl module
Date: Tue, 20 Feb 2007 13:16:01 -0800
Message-ID: <20070220211601.GA27598@localdomain>
References: <11720024233629-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 20 22:16:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJcLI-0004Kf-SN
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 22:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030420AbXBTVQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 16:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbXBTVQF
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 16:16:05 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33581 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030420AbXBTVQE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 16:16:04 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 9388B7DC091;
	Tue, 20 Feb 2007 13:16:01 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 20 Feb 2007 13:16:01 -0800
Content-Disposition: inline
In-Reply-To: <11720024233629-git-send-email-tytso@mit.edu>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40262>

Theodore Ts'o <tytso@mit.edu> wrote:
> Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

Thanks.  I've been meaning to add something like this myself.

config_int() would be nice, too :)

-- 
Eric Wong
