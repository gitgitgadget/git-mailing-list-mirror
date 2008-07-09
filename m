From: Tom Werner <pubsub@rubyisawesome.com>
Subject: git protocol specification
Date: Wed, 09 Jul 2008 11:23:45 -0700
Message-ID: <48750231.4020805@rubyisawesome.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000601060807030809000604"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 20:23:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGeKW-0005ya-9J
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 20:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbYGISWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 14:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYGISWy
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 14:22:54 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:61723 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbYGISWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 14:22:53 -0400
Received: by yx-out-2324.google.com with SMTP id 8so881202yxm.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 11:22:52 -0700 (PDT)
Received: by 10.114.89.1 with SMTP id m1mr9810072wab.146.1215627772072;
        Wed, 09 Jul 2008 11:22:52 -0700 (PDT)
Received: from ?208.84.6.185? ( [208.84.6.185])
        by mx.google.com with ESMTPS id d20sm9725638waa.37.2008.07.09.11.22.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jul 2008 11:22:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87902>

This is a multi-part message in MIME format.
--------------000601060807030809000604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm working on a flexible Erlang replacement for git-daemon and would 
like to know if there is a specification available for the protocol that 
git-upload-pack and git-receive-pack use. I've reverse engineered it but 
have come across some points that seem inconsistent. Before I dig into 
the C code in earnest I wanted to see if there's anything like spec 
document for the system. Thanks!

-- 
Tom Preston-Werner
github.com/mojombo


--------------000601060807030809000604
Content-Type: text/x-vcard; charset=utf-8;
 name="pubsub.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pubsub.vcf"

begin:vcard
fn:Tom Preston-Werner
n:Preston-Werner;Tom
email;internet:tom@mojombo.com
tel;cell:760.672.0832
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------000601060807030809000604--
