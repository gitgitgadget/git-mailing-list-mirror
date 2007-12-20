From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: Draft release notes for 1.5.4 as of -rc1
Date: Thu, 20 Dec 2007 05:13:13 +0200
Organization: Unix Solutions (http://unixsol.org)
Message-ID: <4769DDC9.1030108@unixsol.org>
References: <7vhciers0o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 04:18:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Bva-0007oC-H8
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 04:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbXLTDSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 22:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbXLTDSE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 22:18:04 -0500
Received: from ns.unixsol.org ([193.110.159.2]:45872 "EHLO ns.unixsol.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199AbXLTDSD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 22:18:03 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2007 22:18:03 EST
Received: from [85.187.186.121] ([::ffff:85.187.186.121])
  (AUTH: CRAM-MD5 gf, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by ns.unixsol.org with esmtp; Thu, 20 Dec 2007 05:12:55 +0200
  id 00010048.4769DDB7.00007FC1
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <7vhciers0o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68967>

On 12/20/07 04:58, Junio C Hamano wrote:
>  * "git peek-remote" is deprecated, as "git ls-remote" was written in C
>    and works for all transports, and will be removed in the future.

For me it is not clear from the above which command will be removed. If
I understand it correctly probably this should sound better:

   * "git peek-remote" is deprecated and will be removed in the future.
      The command was replaced by "git ls-remote" which works for all
      transports.

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/
