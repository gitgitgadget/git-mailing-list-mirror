From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git as an sfc member project
Date: Fri, 26 Feb 2010 16:56:44 +0100
Message-ID: <201002261656.47740.jnareb@gmail.com>
References: <20100224154452.GA25872@coredump.intra.peff.net> <m3k4u2mxdr.fsf@localhost.localdomain> <20100226123945.GD10198@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 16:57:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl2Yp-0002pt-S0
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 16:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965215Ab0BZP45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 10:56:57 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:65092 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965189Ab0BZP44 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 10:56:56 -0500
Received: by fxm19 with SMTP id 19so231434fxm.21
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 07:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QgR65O54fE1Y9XYS36p3WIgetwWL9NEwwEfS+PBHOOs=;
        b=JFN6B3um44Ln00+J1EtjzNifl4t85R43s1jv7mU8oBgrJj9bb6oruxndXCOCjlu/e9
         75qvj+FtOPTRKbetWsxVpcJv0dqR01tpxy3EgMwA0zCBlKqHL+b5LurTpkDTV/U6k1LS
         HT61AM4VvZXDyq54Y7mjWy5RRbLdhnUsf3C0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KRUUZVwuB453q8liMc0IOGtWzoUXdkb3VSbqOu7sGC9rbmFYlMPJgTQth4Tg87coCE
         LxUNs/5SdpAfoEdB3ByPi1AqDod8xsnt1LQ+r+1JHXUr3RaxG8HQ24vanGl5SjyNNLTS
         6+WAouKTdIaIG6AR1JxODDot2nraVANoDfgKo=
Received: by 10.223.15.147 with SMTP id k19mr716779faa.87.1267199815281;
        Fri, 26 Feb 2010 07:56:55 -0800 (PST)
Received: from ?192.168.1.13? (abwq120.neoplus.adsl.tpnet.pl [83.8.240.120])
        by mx.google.com with ESMTPS id 16sm201263fxm.11.2010.02.26.07.56.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 07:56:52 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100226123945.GD10198@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141136>

On Fri, 26 Feb 2010, Jeff King wrote:
> On Wed, Feb 24, 2010 at 08:07:13AM -0800, Jakub Narebski wrote:
> 
> > > [This is basically "shortlog -ns | head". I am happy to make it shorter
> > > or longer if people think it should be. Affiliations?]
> > 
> > I wouldn't say I am "key developer"...
> 
> Well, you have a lot of commits, anyway. ;)

Well, there are mainly (310 out of 398 in whole lifetime of git) about
gitweb, which is rather disconnected subsystem of git, started by
Kay Sievers.

> > In the "A note from maintainer", which is send periodically to git
> > mailing list, and which is also available as MaintNotes file in 'todo'
> > branch in git repository, you have the following description of
> > developers at the end of this file:
> 
> Yeah, I thought about that list, but it is very long. Honestly even
> putting ten people on the list seems long to me. I think git has a very
> different distribution of committers than many other projects.

Well, it at least lists contributors by subsystem...

-- 
Jakub Narebski
Poland
