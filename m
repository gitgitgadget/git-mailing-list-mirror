From: Charles Bailey <charles@hashpling.org>
Subject: Re: gitk font configuration
Date: Thu, 20 Dec 2007 12:26:49 +0000
Message-ID: <20071220122649.GA2780@hashpling.org>
References: <Pine.LNX.4.64.0712201318270.27181@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Dec 20 13:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5KV4-0006D8-NC
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 13:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759022AbXLTM1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 07:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760109AbXLTM1A
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 07:27:00 -0500
Received: from pih-relay05.plus.net ([212.159.14.132]:37267 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760069AbXLTM1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 07:27:00 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay05.plus.net with esmtp (Exim) id 1J5KUI-0002hC-C5; Thu, 20 Dec 2007 12:26:55 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBKCQnPg003077;
	Thu, 20 Dec 2007 12:26:49 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBKCQnXc003076;
	Thu, 20 Dec 2007 12:26:49 GMT
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712201318270.27181@ds9.cixit.se>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69000>

On Thu, Dec 20, 2007 at 01:19:54PM +0100, Peter Karlsson wrote:
> Hi!
> 
> I can configure git gui's fonts through its preferences, but gitk does
> not have font settings. And I can't find any documentation on how to
> change the fonts either in the gitk or git-config manual pages. Is
> there any way to change them? I'd really love getting rid of Courier...

gitk creates a .gitk file in your home directory.  If you point your
editor at that file it should be fairly obvious how to change the
fonts.
