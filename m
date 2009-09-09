From: Henrik Tidefelt <tidefelt@isy.liu.se>
Subject: Re: Problem with "dashless options"
Date: Wed, 9 Sep 2009 23:12:12 +0200
Message-ID: <4EEF55B5-46E1-4C06-AA60-62F700F7B279@isy.liu.se>
References: <D69FA890-4249-4DC9-B8AE-C9F105F1AD3B@isy.liu.se> <20090909143455.GA10092@sigill.intra.peff.net> <AB9C50E3-E2BB-4449-B8F9-75777ADE1602@isy.liu.se> <20090909163001.GE4859@laphroaig.corp>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 23:13:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlUTi-0002Bq-Ef
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 23:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321AbZIIVMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2009 17:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319AbZIIVMc
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 17:12:32 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:49687 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbZIIVMa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2009 17:12:30 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id F148B25A9E;
	Wed,  9 Sep 2009 23:12:31 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 05503-05; Thu,  9 Jul 2009 10:11:11 +0200 (MEST)
Received: from [192.168.0.169] (c83-252-172-144.bredband.comhem.se [83.252.172.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 19CB325A9C;
	Wed,  9 Sep 2009 23:12:14 +0200 (MEST)
In-Reply-To: <20090909163001.GE4859@laphroaig.corp>
X-Mailer: Apple Mail (2.1075.2)
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128082>

No, but it is mapped to WHITE FROWNING FACE; I guess I defined it so =20
to avoid the trouble I was previously experiencing from accidentally =20
typing the &nbsp; instead of space without being able to see the =20
difference on screen.  Why would it matter?


Henrik

On 09-09-09, at 18:30 , Pierre Habouzit wrote:

> On Wed, Sep 09, 2009 at 06:26:37PM +0200, Henrik Tidefelt wrote:
>> Yes, that was a strange error.  I applied the patch, but could not
>> reproduce the error any more.  Also, Gustaf Hendeby built git
>> directly from the git distribution (not via MacPorts) on my machine,
>> and could not reproduce the error.  Then I simply tried to clean and
>> build the git from MacPorts again, and voila!, now it works.
>> Something very strange must have happened during the previous build.
>
> Are you using a keyboard mapping where AltGr+space produces an =20
> &nbsp; ?
>
> --=20
> =B7O=B7  Pierre Habouzit
> =B7=B7O                                                madcoder@debia=
n.org
> OOO                                                http://www.madism.=
org
