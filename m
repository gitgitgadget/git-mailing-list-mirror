From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to query the version of a file?
Date: Tue, 28 Sep 2010 13:19:11 +0200
Message-ID: <4CA1CF2F.3050903@drmicha.warpmail.net>
References: <AANLkTi=upbiD5EBumxNxG0YvSRZN0mDfvu7LeU0y0Zpw@mail.gmail.com> <1285670986056-5578850.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sandy2010 <sandeeptt@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 13:19:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0YDG-0006f8-TB
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 13:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937Ab0I1LTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 07:19:04 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:54341 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885Ab0I1LTC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 07:19:02 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5E7981126;
	Tue, 28 Sep 2010 07:19:01 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 28 Sep 2010 07:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=kWoqRQAyHLGUzto/7zU5ngZ8y08=; b=gqh2zJKD4UYrgp/SYdFo0H1Evq7L2n8oF2ptdlNYmDGml/HPoFfZmdXvcQnWvhOV6gLKn391+mEjOIEsBl5rS9Xb2IxxlgKEhPdY0hyVhOWEoZsnoGwYnFoiIKwaFTY4YgdYLQ2JEu8Ii1DsIOf8sj+p1xNW0yNmuc61E+EzE+I=
X-Sasl-enc: +LX8Q5gm4UeZpeYrFgGv7+CdGAl2XerhlGVcs4VgfvTV 1285672741
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E29BA5E4B12;
	Tue, 28 Sep 2010 07:19:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <1285670986056-5578850.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157406>

sandy2010 venit, vidit, dixit 28.09.2010 12:49:
> 
> I do not see the reply to this thread. I'm unable to find how to find the
> version of a checked out file? Also, how do I view an older version?

Todd already answered to your address as well as to the list (3 days
ago). Your 2nd question is answered in the same place he pointed you to:

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#viewing-old-file-versions

Now, what do you think is the top hit when googling "git view older
version" ;)

Michael
