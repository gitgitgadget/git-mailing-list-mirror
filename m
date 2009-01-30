From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Quick and dirty mergetool fix - take 2
Date: Fri, 30 Jan 2009 16:18:50 +0000
Message-ID: <20090130161850.GB26321@hashpling.org>
References: <4983241B.6020208@gmail.com> <1233332166-14300-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas =?iso-8859-1?Q?Flod=E9n?= <jonas.floden@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSw6O-0000ZE-Qo
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbZA3QS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbZA3QS4
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:18:56 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:21121 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751896AbZA3QSz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 11:18:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEALy3gknUnw4T/2dsb2JhbADLIIQQBg
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.ptn-ipout02.plus.net with ESMTP; 30 Jan 2009 16:18:50 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1LSw4w-0000qt-AJ; Fri, 30 Jan 2009 16:18:50 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0UGIodK014366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Jan 2009 16:18:50 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0UGIoc8014365;
	Fri, 30 Jan 2009 16:18:50 GMT
Content-Disposition: inline
In-Reply-To: <1233332166-14300-1-git-send-email-charles@hashpling.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: fdf6407d0651afeb284f68e5065cd7b6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107840>

On Fri, Jan 30, 2009 at 04:16:06PM +0000, Charles Bailey wrote:

Sorry, I meant to add this comment to the last patch.

I have a test so I'm more confident about this version. It's not
signed off yet as I want to clean up the new test and make sure I've
considered everything - well more things - but it should at least work
now.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
