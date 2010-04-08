From: Thomas Kistler <tkistler@nvidia.com>
Subject: cherry pick into remote / git-p4
Date: Thu, 8 Apr 2010 08:55:33 -0700
Message-ID: <B978892CA0FBD142827E74F92AC4BBD429B5EDD0BC@HQMAIL03.nvidia.com>
References: <B978892CA0FBD142827E74F92AC4BBD429B2444D4D@HQMAIL03.nvidia.com>
	 <4880E32B-7880-40BF-8AFD-AC00DA457CEE@meyerhome.net>
	 <B978892CA0FBD142827E74F92AC4BBD429B2444D5C@HQMAIL03.nvidia.com>
	 <1a6be5fa1003231038h695ebbf2k8a765b4a9b6e274d@mail.gmail.com>
	 <B978892CA0FBD142827E74F92AC4BBD429B2444D66@HQMAIL03.nvidia.com>
 <1a6be5fa1003231111pc98bfbbg299ea0f95a7926a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 08 18:00:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzu9p-0003Ab-5l
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 18:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532Ab0DHQAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 12:00:36 -0400
Received: from hqemgate04.nvidia.com ([216.228.121.35]:6338 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758771Ab0DHQAf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 12:00:35 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Apr 2010 12:00:35 EDT
Received: from hqnvupgp04.nvidia.com (Not Verified[172.20.161.48]) by hqemgate04.nvidia.com
	id <B4bbdfbde0001>; Thu, 08 Apr 2010 08:53:02 -0700
Received: from hqemhub03.nvidia.com ([172.17.108.22])
  by hqnvupgp04.nvidia.com (PGP Universal service);
  Thu, 08 Apr 2010 08:55:34 -0700
X-PGP-Universal: processed;
	by hqnvupgp04.nvidia.com on Thu, 08 Apr 2010 08:55:34 -0700
Received: from HQMAIL03.nvidia.com ([172.17.200.13]) by hqemhub03.nvidia.com
 ([172.20.150.15]) with mapi; Thu, 8 Apr 2010 08:55:34 -0700
Thread-Topic: cherry pick into remote / git-p4
Thread-Index: AcrKtFk/880LUyDNSG611JMDJTk5KwMfeJcg
In-Reply-To: <1a6be5fa1003231111pc98bfbbg299ea0f95a7926a7@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144357>

QmVmb3JlIGRvaW5nIGEgbG90IG9mIHdvcmsgSSB3YW50ZWQgdG8gc2VlIHdoZXRoZXIgc29tZW9u
ZSBoYXMgYSBzaW1wbGUgc29sdXRpb24gdG8gY2hlcnJ5IHBpY2sgYSBwYXJ0aWN1bGFyIGNvbW1p
dCBpbnRvIGEgcmVtb3RlIGJyYW5jaCAoYW5kIGJ5IHRoYXQgSSBtZWFuIHRoZSByZWZzL3JlbW90
ZSBicmFuY2ggaW4gdGhlIGxvY2FsIHJlcG9zaXRvcnkgYW5kIG5vdCB0aGUgcmVtb3RlIHJlcG9z
aXRvcnkpLg0KDQpIZXJlIGlzIHNvbWUgbW9yZSBiYWNrZ3JvdW5kLiBJbiBvdXIgc2V0dXAsIHdl
IHBlcmlvZGljYWxseSBidW5jaCBnaXQgY2hhbmdlcyB1cCBhbmQgc3VibWl0IHRoZW0gYmFjayB0
byBhbiBleHRlcm5hbCBwZXJmb3JjZSByZXBvc2l0b3J5ICh1c2luZyBhIG1vZGlmaWVkIHZlcnNp
b24gb2YgZ2l0LXA0KS4gV2hlbiB0aG9zZSBjaGFuZ2VzIGNvbWUgYmFjayBpbnRvIHRoZSBnaXQg
cmVwb3NpdG9yeSAodXNpbmcgZ2l0LXA0IHN5bmMpIHdlIHNlZSB0aGUgY29tYmluZWQgY2hhbmdl
cyByYXRoZXIgdGhhbiB0aGUgaW5kaXZpZHVhbCBvbmVzLCB3aGljaCBjYW4gbGVhZCB0byByZWJh
c2UgY29uZmxpY3RzLiBTbyByYXRoZXIgdGhhbiBpbXBvcnRpbmcgdGhlIGNvbWJpbmVkIGNoYW5n
ZXMsIHdlJ2QgbGlrZSB0byByZXBsYXkgdGhlIGluZGl2aWR1YWwgY2hhbmdlcyBmcm9tIHRoZSBt
YXN0ZXIgYnJhbmNoIGlmIHByZXNlbnQgKHdlIHN0b3JlIHRoZSBnaXQgY29tbWl0IGlkcyBhcyBw
YXJ0IG9mIG91ciBwZXJmb3JjZSBjb21taXQgbWVzc2FnZSBzbyB3ZSBrbm93IHdoaWNoIGlkcyB0
byByZXBsYXkpLiBCdXQgdGhlcmUgZG9lc24ndCBzZWVtIHRvIGJlIGFuIGVhc3kgd2F5IHRvIGRv
IHRoYXQuDQoNCi1UaG9tYXMgDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpUaGlzIGVt
YWlsIG1lc3NhZ2UgaXMgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
KHMpIGFuZCBtYXkgY29udGFpbg0KY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiAgQW55IHVuYXV0
aG9yaXplZCByZXZpZXcsIHVzZSwgZGlzY2xvc3VyZSBvciBkaXN0cmlidXRpb24NCmlzIHByb2hp
Yml0ZWQuICBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgY29u
dGFjdCB0aGUgc2VuZGVyIGJ5DQpyZXBseSBlbWFpbCBhbmQgZGVzdHJveSBhbGwgY29waWVzIG9m
IHRoZSBvcmlnaW5hbCBtZXNzYWdlLg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg==
