From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Compact view of history in gitk
Date: Tue, 29 Sep 2009 17:21:44 +0200
Message-ID: <46a038f90909290821g4bb9cecewace8c8a516b74c78@mail.gmail.com>
References: <4AC1F435.4030802@ubicom.com> <4AC1F88E.7080802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Yakup Akbay <yakbay@ubicom.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 29 17:28:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MseWW-0001j1-1Z
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 17:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbZI2PVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 11:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbZI2PVm
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 11:21:42 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:59948 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbZI2PVl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 11:21:41 -0400
Received: by ewy7 with SMTP id 7so5519366ewy.17
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 08:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=/JMm3ZJhOCfDYBGj7HUp4FGiANwlCefCh3kNvsTVU1s=;
        b=QE+VUaoTUEFVhOwx/Zt3ovILN91jRv2ehMg2mnqwMe0OQ6V/CKLKHNsjen5PCWZAif
         EK5mhkVu1KkhtqORdI7yfx6OLrwGA9nc1XPImi5PPFKhDBbGZ6003ufFa5WMu1HVHwv2
         pZyXwpJ1o6Lm6EIHyK4FoiEBr1zy1NuGx3xEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=c2LBPBRVG6njNF2Scz7uLNJHvl/AD0EydPRFCA9kF7WPhvfV3uJdHLLUfU7PQOuKIK
         ZV4jZaV8aT0+4KYnFtuc9UmeCiwAR8uPAxi4MqRdRZrKmAMdILK0hViw8v12dTjhgFcQ
         sGp7uXzYjb6V+0ZlRITMaAfoZmmeDROxCAR9c=
Received: by 10.210.9.5 with SMTP id 5mr4676911ebi.78.1254237704884; Tue, 29 
	Sep 2009 08:21:44 -0700 (PDT)
In-Reply-To: <4AC1F88E.7080802@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129310>

On Tue, Sep 29, 2009 at 2:07 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> I think, --simplify-by-decoration comes close, even though it may not be
> 100% what you describe.

That is awesome.

Awesomer would be teaching gitk to expand (un-simplify) parts of it.
Probably a pig of a project to do though :-/



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
