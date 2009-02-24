From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: [PATCH RFC 2/2] gitweb: Hyperlink multiple git hashes on the
 same commit message line
Date: Tue, 24 Feb 2009 08:33:37 -0800
Message-ID: <49A42161.4040101@oak.homeunix.org>
References: <1234926043-7471-1-git-send-email-marcel@oak.homeunix.org> <1234926043-7471-2-git-send-email-marcel@oak.homeunix.org> <200902182255.13983.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"fg@one2team.net" <fg@one2team.net>,
	"giuseppe.bilotta@gmail.com" <giuseppe.bilotta@gmail.com>,
	"pasky@suse.cz" <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 17:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc0Lw-00079K-Aa
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 17:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbZBXQkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 11:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756662AbZBXQkX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 11:40:23 -0500
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:21184 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756048AbZBXQkW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 11:40:22 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Feb 2009 11:40:22 EST
Received: (qmail 28949 invoked from network); 24 Feb 2009 16:33:41 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.103.6 with plain)
  by smtp128.sbc.mail.sp1.yahoo.com with SMTP; 24 Feb 2009 16:33:40 -0000
X-YMail-OSG: ITVqsWMVM1mVyJlH5FaR5qGuKr0PfgyJPCOlsdDxz8kjbhOr_Sr0wiA.ZE13zPTlOfP06GexA6t3RIn49kJXJlJf7r6asnKgYGlCULp.G3IZ_zrR99SxoPZXFFDJJSwI0vU42jFFeP.eEQkGH0dBIaaM
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1Lc0Dy-0000fv-T6; Tue, 24 Feb 2009 08:33:38 -0800
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <200902182255.13983.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111311>

Jakub Narebski wrote:
> Do I understand correctly that those patches are not related at all
> semantically or textually, only in that you have them one after other
> (and blob sha-1 in the index line reflects state after former), isn't
> it?

Yes, I think they were independent.  They are related only in that they
are small tweaks to gitweb and products of my bug hyperlinking patch
(not submitted).  I submitted them as a series mainly to group them.
Are you suggesting that I reserve threading patches together for when
one builds upon the previous one?

Marcel
