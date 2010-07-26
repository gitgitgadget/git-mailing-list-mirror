From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: CRLF behavior
Date: Mon, 26 Jul 2010 15:08:57 +0200
Message-ID: <20100726130857.GA6200@pvv.org>
References: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 15:09:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdNQb-0003Jc-0T
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 15:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab0GZNJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 09:09:03 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:38961 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab0GZNJB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 09:09:01 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OdNQP-0006Ql-US; Mon, 26 Jul 2010 15:08:57 +0200
Content-Disposition: inline
In-Reply-To: <1A9EA7E081C3FE46A0F446FFB66D10EB9398F1@FL01EXMB01.trad.tradestation.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151832>

On Wed, Jul 21, 2010 at 05:18:07PM -0400, John Dlugosz wrote:

> I'm running MSYSgit on Windows, and have no mention of any kind of cr=
lf conversion in the config files.=A0 Running git config --list shows n=
othing that would suggest any such setting.=A0 So, my autocrlf is "unsp=
ecified" which according to the docs defaults to false, which means "do=
n't mess with it", right?

msysgit has default core.autocrlf=3Dtrue

- Finn Arne
